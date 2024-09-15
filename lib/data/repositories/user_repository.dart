// UserRepository: 데이터 접근 계층으로서, 사용자 인증 및 Firestore와의 데이터 상호작용만을 담당.
// UserRepository는 데이터의 저장, 업데이트, 삭제 등 CRUD 작업을 책임.
// 상태 관리 로직을 포함 X -> ViewModel or Provider로 처리. (ViewModel이 상태 관리와 UI 상호작용).
// The UserRepository class you provided is responsible for interacting with the Firebase services, specifically handling user authentication via Google Sign-In and managing user data stored in Firestore.

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user/user.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../../core/utils/logger.dart';

class UserRepository {
  final AuthService _authService;
  final FirestoreService _firestoreService;

  UserRepository({
    required AuthService authService,
    required FirestoreService firestoreService,
  })  : _authService = authService,
        _firestoreService = firestoreService;

  Future<User?> signInWithGoogle() async {
    try {
      final firebaseUser = await _authService.signInWithGoogle();

      if (firebaseUser != null) {
        final userDoc = await _firestoreService.getUserDoc(firebaseUser.uid);

        if (userDoc.exists) {
          //Firestore의 DocumentSnapshot에서 data() 메서드를 호출하면, 반환되는 데이터의 타입이 Map<String, dynamic>.
          final userData = userDoc.data() as Map<String, dynamic>;

          final fetchedUser = User.fromJson({
            ...userData,
          });

          await _firestoreService.updateUserDoc(
            firebaseUser.uid,
            {'lastLoginAt': FieldValue.serverTimestamp()},
          );

          Logger.info('User signed in: ${fetchedUser.id}');

          return fetchedUser;
        } else {
          final newUser = User(
            id: firebaseUser.uid,
            name: firebaseUser.displayName ?? '',
            email: firebaseUser.email ?? '',
            imageUrl: firebaseUser.photoURL ?? '',
            region: '',
            followedUsers: [],
            followingUsers: [],
          );

          await _firestoreService.saveUserDoc(
            firebaseUser.uid,
            {
              ...newUser.toJson(),
              'createdAt': FieldValue.serverTimestamp(),
              'lastLoginAt': FieldValue.serverTimestamp(),
            },
          );

          Logger.info('New user created: ${newUser.id}');

          return newUser;
        }
      }
    } catch (e, stackTrace) {
      Logger.error(
        'Error in signInWithGoogle',
        error: e,
        stackTrace: stackTrace,
      );
    }

    // 로그인 실패 시 null 반환.
    //todo client에서 null 처리 (showSnackBar or showDialog or alternative 조사)
    return null;
  }

  Future<void> signOut() async {
    try {
      await _authService.signOut();
      Logger.info('User signed out successfully');
    } catch (e, stackTrace) {
      Logger.error(
        'Error during sign out',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  Future<List<User>> fetchFollows(List<String> followUserIds) async {
    try {
      if (followUserIds.isEmpty) {
        Logger.info('No follow user IDs provided, returning empty list.');

        return [];
      }

      final querySnapshot =
          await _firestoreService.fetchUsersByIds(followUserIds);

      final users = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;

        return User.fromJson(data);
      }).toList();

      Logger.info('Fetched ${users.length} users by follow IDs.');

      return users;
    } catch (e, stackTrace) {
      Logger.error(
        'Error fetching follows',
        error: e,
        stackTrace: stackTrace,
      );

      return [];
    }
  }

  Future<User?> fetchUserById(String userId) async {
    try {
      if (userId.isEmpty) {
        Logger.info('UserId is empty, retruning null');

        return null;
      }
      final doc = await _firestoreService.getUserDoc(userId);

      if (doc.exists) {
        final user = User.fromJson(doc.data() as Map<String, dynamic>);

        Logger.info('Fetched user by ID: $userId');

        return user;
      } else {
        Logger.info('User not found for ID: $userId');

        return null;
      }
    } catch (e, stackTrace) {
      Logger.error(
        'Error fetching user by ID: $userId',
        error: e,
        stackTrace: stackTrace,
      );

      return null;
    }
  }
}
