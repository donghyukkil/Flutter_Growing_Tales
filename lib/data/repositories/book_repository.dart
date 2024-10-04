// Note: This method fetches books from the Google Books API by making a request through the BookService
// and then formats the raw response data into a list of Book Object.

import '../../data/models/book/book.dart';
import '../../data/services/book_service.dart';

import '../../data/models/book/book.dart';
import '../../data/services/book_service.dart';

class BookRepository {
  final BookService _bookService = BookService();

  Future<List<Book>> getBooks(String query, {int startIndex = 0}) async {
    try {
      final booksData =
          await _bookService.fetchBooks(query, startIndex: startIndex);

      List<Book> books = booksData.map<Book>((bookData) {
        return Book(
          id: bookData['id'] ?? 'Unknown',
          title: bookData['volumeInfo']['title'] ?? 'No Title',
          author: (bookData['volumeInfo']['authors'] != null &&
                  bookData['volumeInfo']['authors'].isNotEmpty)
              ? bookData['volumeInfo']['authors'].join(', ')
              : 'Unknown Author',
          thumbnailUrl:
              bookData['volumeInfo']['imageLinks']?['thumbnail'] ?? '',
          pageCount: bookData['volumeInfo']['pageCount'],
          publishedDate: bookData['volumeInfo']['publishedDate'],
        );
      }).toList();

      return books;
    } catch (e) {
      throw Exception('Failed to load books: $e');
    }
  }
}
