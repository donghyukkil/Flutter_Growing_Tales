import 'dart:io';

import 'package:flutter/foundation.dart';

import '../../data/models/diary/diary.dart';
import '../../data/models/user/user.dart';
import '../../data/models/diary/diary_state.dart';
import '../../data/models/diary/diary_with_user.dart';
import '../../ui/view_models/users_view_model.dart';
import '../../data/repositories/diary_repository.dart';
import '../../core/utils/logger.dart';

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

  // 1. for Statistics_screen Diary_Section.
  void fetchDiariesIfNeeded(String userId) {
    if (userId.isEmpty || _state.userDiaries.isNotEmpty) {
      return;
    }

    fetchDiariesByUserId(userId);
  }

  Future<void> fetchDiariesByUserId(String userId) async {
    _updateState(isLoading: true);

    try {
      final userDiaries = await _diaryRepository.getDiariesByUserId(userId);

      final currentUser = _usersViewModel.currentUser;

      if (currentUser != null && currentUser.id == userId) {
        _updateState(
          userDiaries: userDiaries,
          currentUser: currentUser,
          isLoading: false,
        );
      } else {
        _updateState(userDiaries: userDiaries, isLoading: false);
      }
    } catch (e) {
      _updateState(errorMessage: e.toString(), isLoading: false);
    }
  }

  // for Community_screen User_Diary_tile section
  Future<void> fetchAllDiaries() async {
    _updateState(isLoading: true);

    try {
      final allDiaries = await _diaryRepository.getAllDiaries();
      final currentUser = _usersViewModel.currentUser;

      final filteredDiaries = allDiaries.where((diary) {
        return diary.userId != currentUser?.id &&
            diary.settings['publicOption'] == true;
      }).toList();

      List<DiaryWithUser> diariesWithUser = [];

      for (var diary in filteredDiaries) {
        // Note: Diary model does not contain user-specific information like user.name.
        // Therefore, we fetch the user information based on the userId from the diary.
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

      _updateState(allDiariesWithUser: diariesWithUser, isLoading: false);
    } catch (e) {
      _updateState(errorMessage: e.toString(), isLoading: false);
    }
  }

  // for CRUD Diary_screen.
  Future<String> uploadImage(File imageFile) async {
    return _diaryRepository.uploadImage(imageFile);
  }

  Future<bool> saveDiaryEntry({
    required List<String> imageFiles,
    required String title,
    required String contents,
    required List<String> selectedBooks,
    required Map<String, bool> settings,
  }) async {
    _updateState(isLoading: true);

    try {
      //todo pros and cons about Allowing Diary Creation Without Login.

      final currentUser = _usersViewModel.currentUser;

      if (currentUser == null || currentUser.id.isEmpty) {
        Logger.error('User must be logged in to create a diary entry');

        _updateState(
          errorMessage: 'You must be logged in to create a diary entry',
          isLoading: false,
        );

        return false;
      }

      List<String> imagePaths = imageFiles;

      Diary newDiary = Diary(
        id: '',
        userId: _usersViewModel.currentUser?.id ?? '',
        title: title,
        content: contents,
        imageUrls: imagePaths,
        selectedBooks: selectedBooks,
        settings: settings,
        createdAt: DateTime.now(),
      );

      await _diaryRepository.addDiary(newDiary);

      await fetchDiariesByUserId(newDiary.userId);

      _updateState(isLoading: false);

      return true;
    } catch (e) {
      _updateState(errorMessage: e.toString(), isLoading: false);
      Logger.error('Failed to save diary entry: $e');

      return false;
    }
  }

  // for update private State in diary_view_model.
  void _updateState({
    bool? isLoading,
    List<Diary>? userDiaries,
    List<DiaryWithUser>? allDiariesWithUser,
    String? errorMessage,
    DiaryState? newState,
    User? currentUser,
  }) {
    if (newState != null) {
      _state = newState;
    } else {
      _state = _state.copyWith(
        isLoading: isLoading ?? _state.isLoading,
        userDiaries: userDiaries ?? _state.userDiaries,
        allDiariesWithUser: allDiariesWithUser ?? _state.allDiariesWithUser,
        errorMessage: errorMessage,
        currentUser: currentUser ?? _state.currentUser,
      );

      // Logger.info('Updated diary state: $_state');

      notifyListeners();
    }
  }

  // for logout.
  void resetState() {
    // Logger.info('Resetting diary state');
    _updateState(newState: DiaryState());
  }

  // ChangeNotifierProxyProvider for Dependency Injection.
  void updateDependencies(
    DiaryRepository diaryRepository,
    UsersViewModel usersViewModel,
  ) {
    _diaryRepository = diaryRepository;
    _usersViewModel = usersViewModel;

    notifyListeners();
  }
}
