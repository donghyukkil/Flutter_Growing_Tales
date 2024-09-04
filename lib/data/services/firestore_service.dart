// For Firestore operations (fetching users, CRUD user data).
// FirestoreService에서 Firestore 상호작용 캡슐화해서 UserRepository에서 호출해서 사용.

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot> getUserDoc(String userId) {
    return _firestore.collection('users').doc(userId).get();
  }

  Future<void> saveUserDoc(String userId, Map<String, dynamic> data) {
    return _firestore.collection('users').doc(userId).set(data);
  }

  Future<void> updateUserDoc(String userId, Map<String, dynamic> data) {
    return _firestore.collection('users').doc(userId).update(data);
  }

  Future<QuerySnapshot> fetchUsersByIds(List<String> userIds) {
    return _firestore.collection('users').where('name', whereIn: userIds).get();
  }
}
