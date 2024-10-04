import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/exception/exceptions.dart';
import '../../core/utils/keyword_filter.dart';
import '../../core/config/google_books_api_config.dart';

class BookService {
  Future<List<dynamic>> fetchBooks(String query, {int startIndex = 0}) async {
    if (containsBannedKeyword(query)) {
      throw BannedKeywordException('Inappropriate content detected.');
    }

    final response = await http.get(Uri.parse(
        '$googleBooksBaseUrl?q=$query&startIndex=$startIndex&maxResults=$googleBooksMaxResults&key=$googleBooksApiKey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return data['items'] ?? [];
    } else {
      throw Exception('Failed to load books');
    }
  }
}
