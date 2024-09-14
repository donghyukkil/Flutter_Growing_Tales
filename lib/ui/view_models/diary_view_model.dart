import 'dart:io';

import 'package:flutter/foundation.dart';

import '../../data/models/diary/diary.dart';
import '../../data/models/user/user.dart';
import '../../data/models/diary/diary_state.dart';
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
      //todo 계속된 요청 해결하기. 해당 스크린이 나타날 때 한번만 fetch 되도록.
      // Logger.info('test allDiares $allDiaries');

      _updateState(allDiaries: allDiaries, isLoading: false);
    } catch (e) {
      _updateState(errorMessage: e.toString(), isLoading: false);
    }
  }

  // for CRUD Diary_screen.
  Future<void> addDiary(Diary diary) async {
    _state = _state.copyWith(isLoading: true);

    try {
      await _diaryRepository.addDiary(diary);
      await fetchDiariesByUserId(diary.userId);
    } catch (e) {
      _state = _state.copyWith(
        errorMessage: e.toString(),
        isLoading: false,
      );
    }
  }

  Future<String> uploadImage(File imageFile) async {
    return _diaryRepository.uploadImageToFirebase(imageFile);
  }

  Future<void> saveDiaryEntry({
    required List<String> imageFiles,
    required String title,
    required String contents,
    required List<String> selectedBooks,
    required Map<String, bool> settings,
  }) async {
    _updateState(isLoading: true);

    try {
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
    } catch (e) {
      _updateState(errorMessage: e.toString(), isLoading: false);
      Logger.error('Failed to save diary entry: $e');
    }
  }

  // for update private State in diary_view_model.
  void _updateState({
    bool? isLoading,
    List<Diary>? userDiaries,
    List<Diary>? allDiaries,
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
        allDiaries: allDiaries ?? _state.allDiaries,
        errorMessage: errorMessage,
        currentUser: currentUser ?? _state.currentUser,
      );

      Logger.info('Updated diary state: $_state');

      notifyListeners();
    }
  }

  // for logout.
  void resetState() {
    // Logger.info('Resetting diary state');
    _updateState(newState: DiaryState());
  }

  // for ChangeNotifierProxyProvider (Dependency Injection).
  void updateDependencies(
    DiaryRepository diaryRepository,
    UsersViewModel usersViewModel,
  ) {
    _diaryRepository = diaryRepository;
    _usersViewModel = usersViewModel;

    notifyListeners();
  }
}
