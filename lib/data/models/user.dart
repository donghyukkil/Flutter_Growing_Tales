import 'package:freezed_annotation/freezed_annotation.dart';

// Freezed가 생성할 파일을 지정 -> flutter pub run build_runner build
// 불변 객체 생성. Equality, copyWith 쉽게 하는 freezed 파일 생성.
part 'user.freezed.dart';

//  JSON 직렬화 및 역직렬화를 위한 파일
part 'user.g.dart';

@freezed
class User with _$User {
  // factory 생성자를 사용해서 User 클래스의 불변 인스턴스를 생성
  const factory User({
    required String id,
    required String imageUrl,
    required String name,
    required String email,
    required String region,
    @Default([]) List<String> followedUsers,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
