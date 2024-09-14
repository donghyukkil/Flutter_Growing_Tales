import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadFile(File file, String filePath) async {
    try {
      Reference storageRef = _storage.ref().child(filePath);
      UploadTask uploadTask = storageRef.putFile(file);
      await uploadTask;

      return await storageRef.getDownloadURL();
    } catch (e) {
      rethrow;
    }
  }
}
