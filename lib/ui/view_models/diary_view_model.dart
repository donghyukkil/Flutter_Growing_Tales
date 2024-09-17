import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import '../../data/models/diary/diary.dart';
import '../../data/models/user/user.dart';
import '../../data/models/diary/diary_state.dart';
import '../../data/models/diary/diary_with_user.dart';
import '../../ui/view_models/users_view_model.dart';
import '../../data/repositories/diary_repository.dart';
import '../../core/utils/logger.dart';
import '../../core/utils/image_utils.dart';

class DiaryViewModel extends ChangeNotifier {
  DiaryRepository _diaryRepository;
  UsersViewModel _usersViewModel;

  DiaryState _state = DiaryState();

  DiaryViewModel({
    required DiaryRepository diaryRepository,
    required UsersViewModel usersViewModel,
  })  : _diaryRepository = diaryRepository,
        _usersViewModel = usersViewModel;

  DiaryState get state => _state;
  bool get hasFetchedDiaries => _hasFetchedDiaries;

  bool _hasFetchedDiaries = false;

  // Note: 1. for common use method.

  void updateState(DiaryState newState) {
    Logger.info('Updating state');
    _state = newState;
    notifyListeners();
  }

  void resetState() {
    Logger.info('Resetting state');
    _hasFetchedDiaries = false;
    updateState(DiaryState());
  }

  // ChangeNotifierProxyProvider for Dependency Injection.
  void updateDependencies(
    DiaryRepository diaryRepository,
    UsersViewModel usersViewModel,
  ) {
    Logger.info('Updating dependencies');
    _diaryRepository = diaryRepository;
    _usersViewModel = usersViewModel;
    notifyListeners();
  }

  // 2. for Statistics_screen actions.
  void fetchDiariesIfNeeded(String userId) {
    Logger.info('fetchDiariesIfNeeded called with userId: $userId');

    if (userId.isEmpty || _state.userDiaries.isNotEmpty || _hasFetchedDiaries) {
      Logger.info(
        'Skipping fetch: User ID is empty, diaries already loaded, already fetching, or fetch completed.',
      );

      return;
    }

    fetchDiariesByUserId(userId);
  }

  Future<void> fetchDiariesByUserId(String userId) async {
    Logger.info('Fetching diaries for userId: $userId');
    updateState(_state.copyWith(isLoading: true));

    try {
      final userDiaries = await _diaryRepository.getDiariesByUserId(userId);
      final currentUser = _usersViewModel.currentUser;

      updateState(_state.copyWith(
        userDiaries: userDiaries,
        currentUser: currentUser,
        isLoading: false,
      ));

      _hasFetchedDiaries = true;
      Logger.info('Successfully fetched diaries for userId: $userId');
    } catch (e) {
      updateState(_state.copyWith(
        errorMessage: e.toString(),
        isLoading: false,
      ));
      Logger.error('Failed to fetch diaries for userId: $userId - Error: $e');
    }
  }

  // for CRUD Diary_screen.
  Future<void> saveEntry({
    required String title,
    required String contents,
    required List<String> selectedBooks,
    required Map<String, bool> settings,
    required Function onSuccess,
    required Function(String) onError,
  }) async {
    Logger.info('Attempting to save entry with title: $title');

    if (_state.isSaved) {
      Logger.info('Entry has already been saved');
      onError('This entry has already been saved.');

      return;
    }

    final currentUser = _usersViewModel.currentUser;

    if (currentUser == null || currentUser.id.isEmpty) {
      onError('You must be logged in to create a diary entry.');
      updateState(_state.copyWith(isLoading: false));

      return;
    }

    updateState(_state.copyWith(isLoading: true));

    try {
      List<String> imagePaths = [];

      final uploadTasks = _state.imageFiles.map((imageFile) async {
        File file = File(imageFile.path);
        File compressedImage = await compressImage(file);

        return await uploadImage(compressedImage);
      }).toList();

      imagePaths.addAll(await Future.wait(uploadTasks));

      final imagesToSave =
          imagePaths.isNotEmpty ? imagePaths : ['assets/dummy1.png'];

      Diary newDiary = Diary(
        id: '',
        userId: currentUser.id,
        title: title,
        content: contents,
        imageUrls: imagesToSave,
        selectedBooks: selectedBooks,
        settings: settings,
        createdAt: DateTime.now(),
      );

      await _diaryRepository.addDiary(newDiary);
      await fetchDiariesByUserId(newDiary.userId);

      updateState(_state.copyWith(isSaved: true, isLoading: false));
      Logger.info('Successfully saved entry with title: $title');
      onSuccess();
    } catch (e) {
      updateState(_state.copyWith(isLoading: false));
      Logger.error('Failed to save diary entry: $e');
      onError('Failed to save diary entry');
    }
  }

  // Note: to switch local state in Statistics screen.
  void togglePublicOption(bool value) {
    Logger.info('Toggling public option to $value');
    updateState(_state.copyWith(isPublic: value));
  }

  void toggleShowName(bool value) {
    Logger.info('Toggling show name to $value');
    updateState(_state.copyWith(showName: value));
  }

  void toggleShowRegion(bool value) {
    Logger.info('Toggling show region to $value');
    updateState(_state.copyWith(showRegion: value));
  }

  void resetSaveFlag() {
    Logger.info('Resetting save flag');
    updateState(_state.copyWith(isSaved: false));
  }

  void addImages(List<XFile> images) {
    Logger.info('Adding images: ${images.length} files');
    updateState(_state.copyWith(imageFiles: [...state.imageFiles, ...images]));
  }

  Future<String> uploadImage(File imageFile) async {
    Logger.info('Uploading image: ${imageFile.path}');

    return await _diaryRepository.uploadImage(imageFile);
  }

  // 3. for Community_screen User_Diary_tile section
  Future<void> fetchAllDiaries() async {
    Logger.info('Fetching all diaries');
    updateState(_state.copyWith(isLoading: true));

    try {
      final allDiaries = await _diaryRepository.getAllDiaries();
      final currentUser = _usersViewModel.currentUser;

      final filteredDiaries = allDiaries.where((diary) {
        return diary.userId != currentUser?.id &&
            diary.settings['publicOption'] == true;
      }).toList();

      List<DiaryWithUser> diariesWithUser = [];

      for (var diary in filteredDiaries) {
        User? fetchedUserInformation =
            await _usersViewModel.getUserById(diary.userId);

        if (fetchedUserInformation != null) {
          diariesWithUser.add(
            DiaryWithUser(
              diary: diary,
              userName: diary.settings['showName'] == true
                  ? fetchedUserInformation.name
                  : 'Anonymous',
              userRegion: diary.settings['showRegion'] == true
                  ? fetchedUserInformation.region
                  : 'Region Hidden',
            ),
          );
        } else {
          diariesWithUser.add(
            DiaryWithUser(
              diary: diary,
              userName: 'Unknown User',
              userRegion: 'Unknown Region',
            ),
          );
        }
      }

      updateState(_state.copyWith(
        allDiariesWithUser: diariesWithUser,
        isLoading: false,
      ));
      Logger.info('Successfully fetched all diaries');
    } catch (e) {
      updateState(
          _state.copyWith(errorMessage: e.toString(), isLoading: false));
      Logger.error('Failed to fetch all diaries - Error: $e');
    }
  }
}
