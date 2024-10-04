import 'package:flutter_dotenv/flutter_dotenv.dart';

const String googleBooksBaseUrl = 'https://www.googleapis.com/books/v1/volumes';
const int googleBooksMaxResults = 30;

final String googleBooksApiKey =
    dotenv.env['GOOGLE_BOOKS_API_KEY'] ?? 'API_KEY_NOT_FOUND';
