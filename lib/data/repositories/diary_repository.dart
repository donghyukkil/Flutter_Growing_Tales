// firestore와 통신 담당.

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/diary.dart';

class DiaryRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Diary>> getDiariesByUserId(String userId) async {
    try {
      final querySnapshot = await _firestore
          .collection('diaries')
          .where('userId', isEqualTo: userId)
          .get();

      return querySnapshot.docs
          .map((doc) => Diary.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print('Error getting diaries: $e');

      return [];
    }
  }

  Future<List<Diary>> getAllDiaries() async {
    try {
      final querySnapshot = await _firestore.collection('diaries').get();

      return querySnapshot.docs
          .map((doc) => Diary.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print('Error getting all diaries: $e');

      return [];
    }
  }

  Future<void> addDiary(Diary diary) async {
    try {
      await _firestore.collection('diaries').add(diary.toJson());
    } catch (e) {
      print('Error adding diary: $e');
    }
  }
}
