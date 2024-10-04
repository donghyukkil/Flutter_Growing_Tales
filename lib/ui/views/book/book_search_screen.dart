import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:growing_tales/data/repositories/book_repository.dart';

import '../../../core/config/google_books_api_config.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/exception/exceptions.dart';
import '../../../data/models/book/book.dart';
import '../../../core/widgets/circular_back_button.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/utils/multi_style_text_editing_controller.dart';

//todo :add 버튼 아이템 local state로 관리 -> viewmodel book State에 넘기기

class BookSearchScreen extends StatefulWidget {
  const BookSearchScreen({super.key});

  @override
  State<BookSearchScreen> createState() => _BookSearchScreenState();
}

class _BookSearchScreenState extends State<BookSearchScreen> {
  final MultiStyleTextEditingController _textController =
      MultiStyleTextEditingController();
  final ScrollController _scrollController = ScrollController();
  final BookRepository _bookRepository = BookRepository();

  String userInput = '';
  List<Book> booksResult = [];
  bool _isLoading = false;
  bool _hasMoreData = true;
  int _currentStartIndex = 0;
  Timer? _debounce;
  Timer? _throttle;

  @override
  void initState() {
    super.initState();

    _textController.addListener(() {
      userInput = _textController.text;
      _onTextChanged();
    });

    _scrollController.addListener(() {
      // Note: Infinite Scroll (Proactive Fetching)
      double triggerFetchMoreThreshold =
          0.7 * _scrollController.position.maxScrollExtent;

      if (_scrollController.position.pixels > triggerFetchMoreThreshold &&
          !_isLoading) {
        _throttleLoadMoreBooks();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _throttleLoadMoreBooks() {
    if (_throttle?.isActive ?? false) return;

    _throttle = Timer(const Duration(seconds: 1), () {
      _loadMoreBooks();
    });
  }

  void _onTextChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _currentStartIndex = 0;
        booksResult.clear();
        _searchBooks();
      });
    });
  }

  Future<void> _loadMoreBooks() async {
    if (!_hasMoreData || _isLoading) return;

    setState(() {
      _isLoading = true;
    });

    await _searchBooks();
  }

  Future<void> _searchBooks() async {
    if (userInput.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final books = await _bookRepository.getBooks(userInput,
          startIndex: _currentStartIndex);

      setState(() {
        booksResult.addAll(books);
        _hasMoreData = books.length == googleBooksMaxResults;
        _currentStartIndex += books.length;
      });
    } on BannedKeywordException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message),
      ));
    } catch (e) {
      print("Error fetching books: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to load books. Please try again later.'),
      ));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _refreshBooks() async {
    setState(() {
      _currentStartIndex = 0;
      booksResult.clear();
      _hasMoreData = false;
    });

    await _searchBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Search'),
        leading: Padding(
          padding: EdgeInsets.only(left: 15.w),
          child: CircularBackButton(
            onPressed: () {
              context.go('/statistics');
            },
            iconSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: AppConstants.paddingHorizontal20wVertical10h(),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 80.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border(
                  top: BorderSide(width: 2),
                  right: BorderSide(width: 2),
                  bottom: BorderSide(width: 7),
                  left: BorderSide(width: 2),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 3,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            controller: _textController,
                            decoration: InputDecoration(
                                hintText: 'Search your Books',
                                hintStyle: TextStyle(
                                  fontSize: 20.sp,
                                ),
                                border: InputBorder.none),
                          ),
                        ),
                      )),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: booksResult.isEmpty && userInput.isEmpty
                  ? Padding(
                      padding: AppConstants.paddingHorizontal20wVertical10h(),
                      child: Column(
                        children: [
                          SizedBox(height: 50.h),
                          Image.asset('assets/book_search_placeholder.png'),
                          SizedBox(height: 10.h),
                          Center(
                            child: CustomText(
                              text:
                                  'Search for book \nyou’ve read to your child.',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Scrollbar(
                      controller: _scrollController,
                      child: RefreshIndicator(
                        onRefresh: _refreshBooks,
                        child: ListView.builder(
                            controller: _scrollController,
                            itemCount:
                                booksResult.length + (_hasMoreData ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index == booksResult.length && _hasMoreData) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20.0),
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                );
                              }

                              final book = booksResult[index];

                              return Column(
                                children: [
                                  SizedBox(height: 5.h),
                                  SizedBox(
                                    height: 100.h,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 100.w,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(width: 2),
                                              right: BorderSide(width: 2),
                                              bottom: BorderSide(width: 5),
                                              left: BorderSide(width: 2),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            image:
                                                (book.thumbnailUrl.isNotEmpty)
                                                    ? DecorationImage(
                                                        image: NetworkImage(
                                                            book.thumbnailUrl),
                                                        fit: BoxFit.fill,
                                                      )
                                                    : DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: AssetImage(
                                                            'assets/book_placeholder.png'),
                                                      ),
                                          ),
                                        ),
                                        SizedBox(width: 35.w),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                maxLines: 1,
                                                text: book.title,
                                              ),
                                              CustomText(text: book.author),
                                              CustomText(
                                                text: book.pageCount != null
                                                    ? '${book.pageCount} pages'
                                                    : '',
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  CustomText(
                                                    text:
                                                        'Year: ${book.publishedDate?.substring(0, 4) ?? 'Unknown'}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall,
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border(
                                                        top: BorderSide(
                                                            width: 2),
                                                        right: BorderSide(
                                                            width: 2),
                                                        bottom: BorderSide(
                                                            width: 3),
                                                        left: BorderSide(
                                                            width: 2),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 35.w,
                                                          height: 25.h,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppColors
                                                                .followButtonColor,
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        8),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        8)),
                                                          ),
                                                          child: Center(
                                                              child: Text(
                                                            'Add',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodySmall,
                                                          )),
                                                        ),
                                                        Icon(
                                                          Icons.add,
                                                          color: Colors.black,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5.h),
                                  Divider(),
                                ],
                              );
                            }),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
