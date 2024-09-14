import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/utils/timestamp_converter.dart';

part 'diary.freezed.dart';
part 'diary.g.dart';

@freezed
class Diary with _$Diary {
  factory Diary({
    required String id,
    required String userId,
    required String title,
    required String content,
    @Default([]) List<String> imageUrls,
    @Default([]) List<String> likes,
    @Default([]) List<String> comments,
    @Default([]) List<String> selectedBooks,
    @Default({}) Map<String, bool> settings,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
  }) = _Diary;

  factory Diary.fromJson(Map<String, dynamic> json) => _$DiaryFromJson(json);
}
