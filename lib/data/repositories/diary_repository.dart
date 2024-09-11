// for communicate firestore.

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/services/firestore_service.dart';
import '../models/diary/diary.dart';
import '../../core/utils/logger.dart';

class DiaryRepository {
  final FirestoreService _firestoreService;

  DiaryRepository(this._firestoreService);

  Future<List<Diary>> _fetchDiaries(
      Future<QuerySnapshot> Function(CollectionReference) queryFunction) async {
    try {
      final querySnapshot =
          await queryFunction(_firestoreService.getCollection('diaries'));

      return querySnapshot.docs
          .map((doc) => Diary.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e, stackTrace) {
      Logger.error(
        'Error getting diaries by userId',
        error: e,
        stackTrace: stackTrace,
      );

      return [];
    }
  }

  Future<List<Diary>> getDiariesByUserId(String userId) async {
    return _fetchDiaries(
        (collection) => collection.where('userId', isEqualTo: userId).get());
  }

  Future<List<Diary>> getAllDiaries() async {
    return _fetchDiaries((collection) => collection.get());
  }

  Future<void> addDiary(Diary diary) async {
    try {
      await _firestoreService.getCollection('diaries').add(diary.toJson());
      // Logger.info('Diary added successfully: ${diary.id}');
    } catch (e, stackTrace) {
      Logger.error(
        'Error adding diary',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }
}
