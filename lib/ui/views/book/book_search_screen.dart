import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/circular_back_button.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/utils/multi_style_text_editing_controller.dart';
import '../../../ui/view_models/book_view_model.dart';

class BookSearchScreen extends StatefulWidget {
  const BookSearchScreen({super.key});

  @override
  State<BookSearchScreen> createState() => _BookSearchScreenState();
}

class _BookSearchScreenState extends State<BookSearchScreen> {
  final MultiStyleTextEditingController _textController =
      MultiStyleTextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _textController.addListener(() {
      final userInput = _textController.text;
      context.read<BookViewModel>().onUserInputChanged(userInput);

      if (userInput.isEmpty) {
        context.read<BookViewModel>().clearBooksResult();
      }
    });

    _scrollController.addListener(() {
      // Note: Infinite Scroll (Proactive Fetching)
      double triggerFetchMoreThreshold =
          0.7 * _scrollController.position.maxScrollExtent;

      if (_scrollController.position.pixels > triggerFetchMoreThreshold) {
        context.read<BookViewModel>().throttleLoadMoreBooks();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();
    super.dispose();
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
              context.read<BookViewModel>().clearBooksResult();
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
              height: 80.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border(
                  top: BorderSide(width: 2),
                  right: BorderSide(width: 4),
                  bottom: BorderSide(width: 7),
                  left: BorderSide(width: 2),
                ),
              ),
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
            ),
            SizedBox(height: 20.h),
            Expanded(child: Consumer<BookViewModel>(
                builder: (context, bookViewModel, child) {
              final booksResult = bookViewModel.booksResult;
              final isLoading = bookViewModel.isLoading;

              if (isLoading && booksResult.isEmpty) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (booksResult.isEmpty && _textController.text.isEmpty) {
                return Padding(
                  padding: AppConstants.paddingHorizontal20wVertical10h(),
                  child: Column(
                    children: [
                      SizedBox(height: 50.h),
                      Image.asset('assets/book_search_placeholder.png'),
                      SizedBox(height: 10.h),
                      Center(
                        child: CustomText(
                          text: 'Search for book \nyou’ve read to your child.',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return Scrollbar(
                controller: _scrollController,
                child: RefreshIndicator(
                  onRefresh: bookViewModel.refreshBooks,
                  child: ListView.builder(
                      controller: _scrollController,
                      itemCount: booksResult.length,
                      itemBuilder: (context, index) {
                        final book = booksResult[index];

                        return Column(
                          children: [
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
                                      borderRadius: BorderRadius.circular(5),
                                      image: (book.thumbnailUrl.isNotEmpty)
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
                                        CustomText(
                                          text: book.author,
                                          maxLines: 1,
                                        ),
                                        CustomText(
                                          text: book.pageCount != null
                                              ? '${book.pageCount} pages'
                                              : '',
                                          maxLines: 1,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                              text:
                                                  'Year: ${book.publishedDate?.substring(0, 4) ?? 'Unknown'}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                              maxLines: 1,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border(
                                                  top: BorderSide(width: 2),
                                                  right: BorderSide(width: 2),
                                                  bottom: BorderSide(width: 3),
                                                  left: BorderSide(width: 2),
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 35.w,
                                                    height: 25.h,
                                                    decoration: BoxDecoration(
                                                      color: AppColors
                                                          .followButtonColor,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(8),
                                                              bottomLeft: Radius
                                                                  .circular(8)),
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                      'Add',
                                                      style: Theme.of(context)
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
              );
            }))
          ],
        ),
      ),
    );
  }
}
