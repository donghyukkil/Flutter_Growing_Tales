import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/constants/app_constants.dart';
import '../../core/exception/exceptions.dart';
import '../../core/utils/keyword_filter.dart';

class BookService {
  static const String baseUrl = 'https://www.googleapis.com/books/v1/volumes';
  static const int maxResults = 30;

  Future<List<dynamic>> fetchBooks(String query, {int startIndex = 0}) async {
    if (containsBannedKeyword(query)) {
      throw BannedKeywordException('Inappropriate content detected.');
    }

    final response = await http.get(Uri.parse(
        '$baseUrl?q=$query&startIndex=$startIndex&maxResults=$maxResults'));

    // print(response.body.toString());

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return data['items'] ?? [];
    } else {
      throw Exception('Failed to load books');
    }
  }
}
