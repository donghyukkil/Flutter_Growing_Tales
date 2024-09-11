import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/custom_theme_extension.dart';
import '../../core/widgets/custom_text.dart';
import '../../core/widgets/user_info_tile.dart';
import '../../data/dummy_data.dart';
import '../../data/models/diary/diary.dart';

class DiaryDetailScreen extends StatelessWidget {
  final Diary diary;

  const DiaryDetailScreen({super.key, required this.diary});

  @override
  Widget build(BuildContext context) {
    String fullContext = diary.content;
    int splitIndex = (fullContext.length / 2).round();
    String firstHalf = fullContext.substring(0, splitIndex);
    String secondHalf = fullContext.substring(splitIndex);

    return Scaffold(
      appBar: AppBar(
        title: Text('Diary_detail'),
      ),
      body: Padding(
        padding: Theme.of(context).paddingHorizontal20Vertical10,
        child: ListView(
          children: [
            UserInfoTile(
              imageUrl: 'assets/dummy1.png',
              name: 'Donghyuk',
              region: 'Seoul',
              buttonText: 'Logout',
              onButtonPressed: () {},
            ),
            SizedBox(height: 10.h),
            Semantics(
              label: 'Diary Title',
              child: Padding(
                padding: Theme.of(context).paddingAll12,
                child: Align(
                  alignment: Alignment.center,
                  child: CustomText(
                    text: diary.title ?? 'No Title',
                    style: TextStyle(fontSize: 30.sp),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Semantics(
              label: 'Action Icons',
              child: Padding(
                padding: Theme.of(context).paddingAll12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [Icon(Icons.heart_broken), Text('Like')]),
                    Container(height: 24, width: 2, color: Colors.black),
                    Row(children: [Icon(Icons.share_outlined), Text('Share')]),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Semantics(
              label: 'body1',
              child: Container(
                padding: Theme.of(context).paddingAll12,
                child: CustomText(
                  text: firstHalf,
                  style: TextStyle(fontSize: 20.sp),
                  maxLines: null,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Semantics(
              label: 'bodyImages',
              child: Padding(
                padding: Theme.of(context).paddingAll12,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                        left: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                        right: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 7,
                        ),
                      ),
                      borderRadius: BorderRadius.circular((10.r))),
                  height: 200.h,
                  child: CarouselSlider.builder(
                    itemCount: dummyDiary.length,
                    itemBuilder: (context, index, realIndex) {
                      return Column(
                        children: [
                          Expanded(
                            child: Image.asset(
                              'assets/big-image-2.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      );
                    },
                    options: CarouselOptions(
                      height: 250.h,
                      // enlargeCenterPage: true,
                      autoPlay: false,
                      aspectRatio: 16 / 9,
                      enableInfiniteScroll: true,
                      autoPlayInterval: Duration(seconds: 3),
                      onPageChanged: (index, reason) {
                        print('Page changed to index: $index');
                      },
                      viewportFraction: 1,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Semantics(
              label: 'body2',
              child: Container(
                padding: Theme.of(context).paddingAll12,
                child: CustomText(
                  text: secondHalf,
                  style: TextStyle(fontSize: 20.sp),
                  maxLines: null,
                ),
              ),
            ),
            SizedBox(height: 20),
            UserInfoTile(
                imageUrl: 'assets/dummy2.png',
                name: 'USER2',
                region: 'Seoul',
                buttonText: 'Follow',
                onButtonPressed: () {}),
          ],
        ),
      ),
    );
  }
}
