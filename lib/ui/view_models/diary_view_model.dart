import 'package:flutter/foundation.dart';

import '../../data/models/diary.dart';
import '../../data/models/diary_state.dart';
import '../../data/repositories/diary_repository.dart';

class DiaryViewModel extends ChangeNotifier {
  final DiaryRepository _diaryRepository;

  // Using DiaryState instead of individual lists encapsulates all these variable.
  // This approachs keeps the data representaion(Diary) distinct from the application`s UI state (DiarayStatE)

  // List<Diary> _diaries = [];
  // final List<Diary> _followedUserDiaries = [];
  DiaryState _state = DiaryState();

  DiaryViewModel({required DiaryRepository diaryRepository})
      : _diaryRepository = diaryRepository;

  DiaryState get state => _state;

  Future<void> fetchDiariesByUserId(String userId) async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    try {
      final userDiaries = await _diaryRepository.getDiariesByUserId(userId);

      _state = _state.copyWith(
        userDiaries: userDiaries,
        isLoading: false,
      );
    } catch (e) {
      _state = _state.copyWith(
        errorMessage: e.toString(),
        isLoading: false,
      );
    }

    notifyListeners();
  }

  Future<void> fetchAllDiaries() async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    try {
      final allDiaries = await _diaryRepository.getAllDiaries();
      //todo 계속된 요청 해결하기. 해당 스크린이 나타날 때 한번만 fetch 되도록.
      // print('test allDiares $allDiaries');

      _state = _state.copyWith(
        allDiaries: allDiaries,
        isLoading: false,
      );
    } catch (e) {
      _state = _state.copyWith(
        errorMessage: e.toString(),
        isLoading: false,
      );
    }

    notifyListeners();
  }

  Future<void> addDiary(Diary diary) async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    try {
      await _diaryRepository.addDiary(diary);
      await fetchDiariesByUserId(diary.userId);
    } catch (e) {
      _state = _state.copyWith(
        errorMessage: e.toString(),
        isLoading: false,
      );
    }

    // notifyListeners();
  }
}
