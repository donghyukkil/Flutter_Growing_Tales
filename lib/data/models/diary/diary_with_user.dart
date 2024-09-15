import '../diary/diary.dart';

class DiaryWithUser {
  final Diary diary;
  final String userName;
  final String userRegion;

  DiaryWithUser({
    required this.diary,
    required this.userName,
    required this.userRegion,
  });
}
