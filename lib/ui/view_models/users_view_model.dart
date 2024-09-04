import 'package:flutter/material.dart';

import '../../data/models/login_state.dart';
import '../../data/models/user.dart';
import '../../data/repositories/user_repository.dart';

class UsersViewModel extends ChangeNotifier {
  final UserRepository _userRepository = UserRepository();
  LoginState _state = const LoginState();
  LoginState get state => _state;

  User? get currentUser => _state.user;

  // Google Sign-In을 통해 로그인 처리
  Future<void> loginWithGoogle() async {
    try {
      _updateState(isLoading: true);

      final user = await _userRepository.signInWithGoogle();

      if (user != null) {
        _updateState(
          user: user,
          errorMessage: null,
        );

        await fetchFollows(user.followedUsers);
      } else {
        _updateState(
          errorMessage: 'Login canceled by user',
          isLoading: false,
        );
      }
    } catch (e) {
      _updateState(
        errorMessage: 'An error occurred: $e',
        isLoading: false,
      );
    }
  }

  Future<void> logout() async {
    await _userRepository.signOut();
    _updateState(
      user: null,
      follows: [],
      errorMessage: null,
    );
  }

  Future<void> fetchFollows(List<String> followedUserIds) async {
    if (followedUserIds.isEmpty) {
      _updateState(
        follows: [],
        isLoading: false,
      );

      return;
    }

    try {
      _updateState(isLoading: true);

      List<User> follows = await _userRepository.fetchFollows(followedUserIds);

      _updateState(
        follows: follows,
        isLoading: false,
      );
    } catch (e) {
      _updateState(
        errorMessage: 'Failed to fetch follows: $e',
        isLoading: false,
      );
    }
  }

  // 여기도 LoginState로 업데이트?
  void _updateState({
    bool? isLoading,
    User? user,
    String? errorMessage,
    List<User>? follows,
  }) {
    _state = state.copyWith(
      isLoading: isLoading ?? _state.isLoading,
      user: user ?? _state.user,
      errorMessage: errorMessage,
      follows: follows ?? _state.follows,
    );

    notifyListeners();
  }
}
