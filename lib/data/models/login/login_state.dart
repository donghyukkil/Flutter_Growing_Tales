import 'package:freezed_annotation/freezed_annotation.dart';

import '../user/user.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default(false) bool isLoading,
    User? user,
    String? errorMessage,
    String? imageUrl,
    @Default([]) List<User> follows,
  }) = _LoginState;
}
