import 'dart:async';

import 'package:flutter/material.dart';
import 'package:growing_tales/core/config/google_books_api_config.dart';

import '../../data/repositories/book_repository.dart';
import '../../core/exception/exceptions.dart';
import '../../data/models/book/book.dart';

class BookViewModel extends ChangeNotifier {
  final BookRepository _bookRepository = BookRepository();

  String userInput = '';
  List<Book> booksResult = [];
  bool isLoading = false;
  bool hasMoreData = true;
  int currentStartIndex = 0;

  Timer? _debounce;
  Timer? _throttle;

  // Debounce mechanism for user input to avoid calling search repeatedly
  void onUserInputChanged(String input) {
    userInput = input;

    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      currentStartIndex = 0;
      booksResult.clear();
      searchBooks();
    });
  }

  // Throttle mechanism for infinite scrolling to load more data
  void throttleLoadMoreBooks() {
    if (_throttle?.isActive ?? false) return;

    _throttle = Timer(const Duration(seconds: 1), () {
      searchBooks();
    });
  }

  Future<void> searchBooks() async {
    if (userInput.isEmpty || !hasMoreData || isLoading) return;

    isLoading = true;
    notifyListeners();

    try {
      final books = await _bookRepository.getBooks(userInput,
          startIndex: currentStartIndex);

      booksResult.addAll(books);
      hasMoreData = books.length == googleBooksMaxResults;
      currentStartIndex += books.length;
    } on BannedKeywordException catch (e) {
      throw BannedKeywordException(e.message);
    } catch (e) {
      throw Exception('Failed to load books: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void clearBooksResult() {
    booksResult.clear();
    currentStartIndex = 0;
    hasMoreData = true;
    notifyListeners();
  }

  Future<void> refreshBooks() async {
    currentStartIndex = 0;
    booksResult.clear();
    hasMoreData = true;

    await searchBooks();
  }

  //todo addBook, deleteBook

  @override
  void dispose() {
    _debounce?.cancel();
    _throttle?.cancel();
    super.dispose();
  }
}
