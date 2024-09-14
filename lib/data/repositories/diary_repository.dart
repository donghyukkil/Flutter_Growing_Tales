import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/services/firestore_service.dart';
import '../../data/services/storage_service.dart';
import '../models/diary/diary.dart';
import '../../core/utils/logger.dart';

class DiaryRepository {
  final FirestoreService _firestoreService;
  final StorageService _storageService;

  DiaryRepository(this._firestoreService, this._storageService);

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
      DocumentReference docRef =
          await _firestoreService.getCollection('diaries').add(diary.toJson());

      await docRef.update({'id': docRef.id});

      Logger.info('Diary added successfully: ${docRef.id}');
    } catch (e, stackTrace) {
      Logger.error(
        'Error adding diary',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  Future<String> uploadImage(File imageFile) async {
    try {
      String filePath = 'images/${DateTime.now().millisecondsSinceEpoch}.jpg';
      return await _storageService.uploadFile(imageFile, filePath);
    } catch (e) {
      Logger.error('Error uploading image: $e');
      rethrow;
    }
  }
}
