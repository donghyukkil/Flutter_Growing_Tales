import 'package:freezed_annotation/freezed_annotation.dart';

part 'book.freezed.dart';
part 'book.g.dart';

@freezed
class Book with _$Book {
  factory Book({
    required String id,
    required String title,
    required String author,
    required String thumbnailUrl,
    int? pageCount, // Optional pageCount property
    String? publishedDate, // Optional publishedDate property
  }) = _Book;

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
}
