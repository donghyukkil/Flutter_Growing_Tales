// DiaryState is a state holder that encapsulates all the state variables related to the Diary model.
// keep the data representation (Diary) distinct from the application’s UI state (DiaryState).
// When using Provider, DiaryState acts as a model for the ViewModel or a ChangeNotifier.

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

import 'diary.dart';
import '../user/user.dart';
import 'diary_with_user.dart';

part 'diary_state.freezed.dart';

@freezed
class DiaryState with _$DiaryState {
  const factory DiaryState({
    @Default(false) bool isLoading,
    @Default([]) List<Diary> userDiaries,
    @Default([]) List<Diary> allDiaries,
    @Default([]) List<Diary> followedUserDiaries,
    @Default([]) List<DiaryWithUser> allDiariesWithUser,
    String? errorMessage,
    User? currentUser,
    @Default(false) bool isSaved,
    @Default(false) bool isPublic,
    @Default(false) bool showName,
    @Default(false) bool showRegion,
    @Default([]) List<XFile> imageFiles,
  }) = _DiaryState;
}
