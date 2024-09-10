// for communicate firestore.

import '../../data/services/firestore_service.dart';
import '../models/diary.dart';
import '../../core/utils/logger.dart';

class DiaryRepository {
  final FirestoreService _firestoreService;

  DiaryRepository(this._firestoreService);

  Future<List<Diary>> getDiariesByUserId(String userId) async {
    try {
      //todo extract to Repository.
      final querySnapshot = await _firestoreService
          .getCollection('diaries')
          .where('userId', isEqualTo: userId)
          .get();

      final diaries = querySnapshot.docs
          .map((doc) => Diary.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      // Logger.info('Fetched ${diaries.length} diaries for user: $userId');

      return diaries;
    } catch (e, stackTrace) {
      Logger.error(
        'Error getting diaries by userId: $userId',
        error: e,
        stackTrace: stackTrace,
      );

      return [];
    }
  }

  Future<List<Diary>> getAllDiaries() async {
    try {
      final querySnapshot =
          await _firestoreService.getCollection('diaries').get();

      final diaries = querySnapshot.docs
          .map((doc) => Diary.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      // Logger.info('Fetched all diaries, count: ${diaries.length}');

      return diaries;
    } catch (e, stackTrace) {
      Logger.error(
        'Error getting all diaries',
        error: e,
        stackTrace: stackTrace,
      );

      return [];
    }
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
