import 'package:flutter/material.dart';

import '../../data/models/login_state.dart';
import '../../data/models/user.dart';
import '../../data/repositories/user_repository.dart';

class UsersViewModel extends ChangeNotifier {
  final UserRepository _userRepository = UserRepository();
  LoginState _state = const LoginState();
  final Map<String, User> _userCache = {};

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
          isLoading: false,
          updateUser: true,
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
      imageUrl: '',
      updateUser: true,
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

      // Cache the fetched users.
      for (var user in follows) {
        _userCache[user.id] = user;
      }

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

  Future<User?> getUserById(String userId) async {
    if (_userCache.containsKey(userId)) {
      //todo.컨텐츠 내용달라지면 업데이트로직.
      print('testcache-----------------');
      return _userCache[userId];
    }
    try {
      final user = await _userRepository.fetchUserById(userId);

      if (user != null) {
        _userCache[userId] = user;
      }

      return user;
    } catch (e) {
      print('Error fetch user by Id: $e');

      return null;
    }
  }

  void _updateState({
    bool? isLoading,
    User? user,
    String? errorMessage,
    List<User>? follows,
    String? imageUrl,
    bool updateUser =
        false, // 상태 관리용 local flags. 상태 객체에는 포함되지 않고 상태가 업데이트 유무를 결정.
  }) {
    print(
      '1. Updating state: isLoading=$isLoading, user=$user, errorMessage=$errorMessage, follows=$follows, imageUrl=$imageUrl',
    );

    _state = state.copyWith(
      isLoading: isLoading ?? _state.isLoading,
      user: updateUser ? user : _state.user,
      errorMessage: errorMessage,
      follows: follows ?? _state.follows,
      imageUrl: imageUrl ?? _state.imageUrl,
    );

    print('2. Updated state: $_state');
    notifyListeners();
  }
}
