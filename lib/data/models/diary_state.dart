// DiaryState is a state holder that encapsulates all the state variables related to the Diary model.
// keep the data representation (Diary) distinct from the application’s UI state (DiaryState).
// When using Provider, DiaryState acts as a model for the ViewModel or a ChangeNotifier.

import 'package:freezed_annotation/freezed_annotation.dart';

import 'diary.dart';
import '../../data/models/user.dart';

part 'diary_state.freezed.dart';

@freezed
class DiaryState with _$DiaryState {
  const factory DiaryState({
    @Default(false) bool isLoading,
    @Default([]) List<Diary> userDiaries,
    @Default([]) List<Diary> allDiaries,
    @Default([]) List<Diary> followedUserDiaries,
    String? errorMessage,
    User? currentUser,
  }) = _DiaryState;
}
