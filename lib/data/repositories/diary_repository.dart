// firestore와 통신 담당.

import '../../data/services/firestore_service.dart';
import '../models/diary.dart';

//todo 추상화하기. -> service/firestore_service로 공통 코드 추출하기

class DiaryRepository {
  final FirestoreService _firestoreService;

  DiaryRepository(this._firestoreService);

  Future<List<Diary>> getDiariesByUserId(String userId) async {
    try {
      final querySnapshot = await _firestoreService
          .getCollection('diaries')
          .where('userId', isEqualTo: userId)
          .get();

      return querySnapshot.docs
          .map((doc) => Diary.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error getting diaries: $e');

      return [];
    }
  }

  Future<List<Diary>> getAllDiaries() async {
    try {
      final querySnapshot =
          await _firestoreService.getCollection('diaries').get();

      return querySnapshot.docs
          .map((doc) => Diary.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error getting all diaries: $e');

      return [];
    }
  }

  Future<void> addDiary(Diary diary) async {
    try {
      await _firestoreService.getCollection('diaries').add(diary.toJson());
    } catch (e) {
      print('Error adding diary: $e');
    }
  }
}
