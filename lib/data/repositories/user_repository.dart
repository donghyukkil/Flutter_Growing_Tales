// UserRepository: 데이터 접근 계층으로서, 사용자 인증 및 Firestore와의 데이터 상호작용만을 담당.
// UserRepository는 데이터의 저장, 업데이트, 삭제 등 CRUD 작업을 책임.
// 상태 관리 로직을 포함 X -> ViewModel or Provider로 처리. (ViewModel이 상태 관리와 UI 상호작용).

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';

class UserRepository {
  //todo: AuthService 인스턴스 생성 ->  DI vs 인스턴스 생성(싱글톤인 경우라면)
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();

  Future<User?> signInWithGoogle() async {
    final firebaseUser = await _authService.signInWithGoogle();

    if (firebaseUser != null) {
      final userDoc = await _firestoreService.getUserDoc(firebaseUser.uid);

      if (userDoc.exists) {
        //Firestore의 DocumentSnapshot에서 data() 메서드를 호출하면, 반환되는 데이터의 타입이 Map<String, dynamic>.
        final userData = userDoc.data() as Map<String, dynamic>;

        // freezed 사용하지 않음.
        // return User(
        //   id: firebaseUser.uid,
        //   name: firebaseUser.displayName ?? '',
        //   email: firebaseUser.email ?? '',
        //   imageUrl: firebaseUser.photoURL ?? '',
        //   region: userData['region'] ?? '',
        //   followedUsers: List<String>.from(
        //     userData['followedUsers'] ?? [],
        //   ),
        // );

        // freezed 사용 시.
        // return User.fromJson(userData);
        final fetchedUser = User.fromJson({
          ...userData,
        });

        await _firestoreService.updateUserDoc(
          firebaseUser.uid,
          {'lastLoginAt': FieldValue.serverTimestamp()},
        );

        return fetchedUser;
      } else {
        final newUser = User(
          id: firebaseUser.uid,
          name: firebaseUser.displayName ?? '',
          email: firebaseUser.email ?? '',
          imageUrl: firebaseUser.photoURL ?? '',
          region: '',
        );

        // freezed 사용하지 않음.
        // await _firestoreService.saveUserDoc(
        //   firebaseUser.uid,
        //   {
        //     'name': firebaseUser.displayName ?? '',
        //     'region': '',
        //     'email': firebaseUser.email ?? '',
        //     'profileImageUrl': firebaseUser.photoURL ?? '',
        //     'createdAt': FieldValue.serverTimestamp(),
        //     'lastLoginAt': FieldValue.serverTimestamp(),
        //     'followedUsers': [],
        //   },
        // );

        // freezed 사용 시
        await _firestoreService.saveUserDoc(
          firebaseUser.uid,
          {
            ...newUser.toJson(),
            'createdAt': FieldValue.serverTimestamp(),
            'lastLoginAt': FieldValue.serverTimestamp(),
          },
        );

        return newUser;
      }
    }

    // 로그인 실패 시 null 반환.
    //todo client에서 null 처리 (showSnackBar or showDialog or alternative 조사)
    return null;
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }

  Future<List<User>> fetchFollows(List<String> followUserIds) async {
    try {
      if (followUserIds.isEmpty) {
        return [];
      }

      final querySnapshot =
          await _firestoreService.fetchUsersByIds(followUserIds);

      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;

        return User.fromJson(data);
      }).toList();
    } catch (e) {
      print('Error fetching follows: $e');

      return [];
    }
  }
}
