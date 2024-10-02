import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../data/dummy_data.dart';

class BookSearchScreen extends StatefulWidget {
  const BookSearchScreen({super.key});

  @override
  State<BookSearchScreen> createState() => _BookSearchScreenState();
}

class _BookSearchScreenState extends State<BookSearchScreen> {
  final textController = TextEditingController();
  String userInput = '';

  @override
  void initState() {
    super.initState();
    textController.addListener(() {
      setState(() {
        userInput = textController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book Search')),
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
                    left: BorderSide(width: 2)),
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
                            controller: textController,
                            decoration: InputDecoration(
                                hintText: 'Search your Books',
                                hintStyle: TextStyle(
                                  fontSize: 20.sp,
                                ),
                                border: InputBorder.none),
                          ),
                        ),
                      )),
                  Expanded(flex: 1, child: Icon(size: 35, Icons.search))
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: ListView.builder(
                  itemCount: dummyBooks.length,
                  itemBuilder: (context, index) {
                    final item = dummyBooks[index];

                    return Column(
                      children: [
                        SizedBox(height: 5.h),
                        SizedBox(
                          width: 300.w,
                          height: 100.h,
                          child: Row(
                            children: [
                              Container(
                                width: 100.w,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 2.w),
                                  borderRadius: BorderRadius.circular(5),
                                  image: item['image'] != null
                                      ? DecorationImage(
                                          image: AssetImage(item['image']!),
                                          fit: BoxFit.cover,
                                        )
                                      : DecorationImage(
                                          fit: BoxFit.cover,
                                          image:
                                              AssetImage('assets/dummy1.png'),
                                        ),
                                ),
                              ),
                              SizedBox(width: 35.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${item['username']}',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  Text(
                                    '${item['title']}',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  SizedBox(height: 10.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          Text('\$ ${1234.toString()}'),
                                          SizedBox(width: 50.w),
                                        ],
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(width: 2)),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 35.w,
                                              height: 25.h,
                                              decoration: BoxDecoration(
                                                color:
                                                    AppColors.followButtonColor,
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(8),
                                                    bottomLeft:
                                                        Radius.circular(8)),
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
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Divider(),
                      ],
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
