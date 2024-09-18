import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:growing_tales/core/utils/dialog_utils.dart';
import 'package:growing_tales/ui/view_models/diary_view_model.dart';
import 'package:provider/provider.dart';

import '../../core/theme/custom_theme_extension.dart';
import '../../core/widgets/custom_text.dart';
import '../../core/widgets/user_info_tile.dart';
import '../../data/models/diary/diary.dart';
import '../../core/utils/menu_utils.dart';

//todo 책 통계 테이블 추가.
//todo 성능 최적화 (이미지 업로드 긴 시간이 걸림, textField 입력 부하 줄이기 (batching, caching, throttle, debounce 적용)
//todo textField 사용자 복사 이벤트 적용이 잘 안됨. textField 부하 탓?

class DiaryDetailScreen extends StatelessWidget {
  final Diary diary;

  const DiaryDetailScreen({super.key, required this.diary});

  @override
  Widget build(BuildContext context) {
    //todo 텍스트가 첫번째 컨테이거를 채우지 못하면 전부 firstHalf에 렌더링하기.
    String fullContext = diary.content;
    int splitIndex = (fullContext.length / 2).round();
    String firstHalf = fullContext.substring(0, splitIndex);
    String secondHalf = fullContext.substring(splitIndex);

    // Note: 	Accessing the Position of the “Settings” Row.
    // This key allow yo to access widget position on the screen.
    final GlobalKey settingsKey = GlobalKey();

    final List<String> menuItems = [
      'Update',
      'Delete',
    ];

    void onSettingsSelected(String value) {
      print('Settings item selected: $value'); // Trace menu selection
      final diaryViewModel =
          Provider.of<DiaryViewModel>(context, listen: false);

      switch (value) {
        case 'Update':
          // diaryViewModel.updateDiary(diary);
          break;
        case 'Delete':
          showCustomDialog(
            context: context,
            title: 'Delete Diary',
            content: 'Are you sure you want to delete this diary?',
            onSettingsPressed: () async {
              diaryViewModel.deleteDiary(diary).then((_) {
                showCustomDialog(
                  context: context,
                  title: 'Delete',
                  content: 'Diary deleted successfully.',
                  onSettingsPressed: () async {
                    context.go('/statistics');
                  },
                  settingsButtonText: 'OK',
                );
              }).catchError((error) {
                showCustomDialog(
                  context: context,
                  title: 'Error',
                  content: 'Failed to delete diary.',
                  onSettingsPressed: () async {
                    context.pop();
                  },
                  settingsButtonText: 'Retry',
                );
              });
            },
            settingsButtonText: 'OK',
          );
          break;
        default:
          print('Unknown action');
      }
    }

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
                  children: [
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Icon(Icons.heart_broken),
                          SizedBox(width: 5.w),
                          Text('Like')
                        ]),
                        Row(children: [
                          Icon(Icons.share_outlined),
                          SizedBox(width: 5.w),
                          Text('Share')
                        ]),
                      ],
                    )),
                    Expanded(
                        child: Row(
                      children: [
                        SizedBox(width: 20.w),
                        Container(height: 24, width: 2, color: Colors.black),
                        SizedBox(width: 20.w),
                        Expanded(
                          child: GestureDetector(
                            key: settingsKey,
                            onTap: () {
                              showSettingsMenu(
                                context: context,
                                settingsKey: settingsKey,
                                menuItems: menuItems,
                                onSelected: onSettingsSelected,
                              );
                            },
                            child: Row(
                              children: [
                                Icon(Icons.settings),
                                SizedBox(width: 5.w),
                                Text('Settings')
                              ],
                            ),
                          ),
                        ),
                      ],
                    ))
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
                    itemCount: diary.imageUrls.length,
                    itemBuilder: (context, index, realIndex) {
                      final imageUrl = diary.imageUrls[index];

                      bool isNetworkImage =
                          Uri.tryParse(imageUrl)?.hasAbsolutePath ?? false;

                      return Column(
                        children: [
                          Expanded(
                            child: isNetworkImage
                                ? Image.network(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      }
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                          'assets/big-image-2.png',
                                          fit: BoxFit.cover);
                                    },
                                  )
                                : Image.asset(
                                    'assets/big-image-2.png',
                                    fit: BoxFit.cover,
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
