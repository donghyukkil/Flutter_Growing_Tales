import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_colors.dart';
import '../../core/widgets/circular_back_button.dart';
import '../../core/theme/custom_theme_extension.dart';
import '../../core/widgets/custom_border_container.dart';
import '../../core/widgets/custom_styled_text_field.dart';
import '../../ui/components/book_list_section.dart';

class DiaryWriteScreen extends StatefulWidget {
  const DiaryWriteScreen({super.key});

  @override
  State<DiaryWriteScreen> createState() => _DiaryWriteScreenState();
}

class _DiaryWriteScreenState extends State<DiaryWriteScreen> {
  String _text = '';
  final List<XFile> _imageFiles = [];
  final ImagePicker _picker = ImagePicker();
  int _currentPicture = 0;
  final TextEditingController _controller = TextEditingController();
  final CarouselSliderController _carouselSliderController =
      CarouselSliderController();

  bool _showOnlyTop = true;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _text = _controller.text;
      });
    });
  }

  void _toggleTopView() {
    setState(() {
      _showOnlyTop = !_showOnlyTop;
    });
  }

  Future<void> _pickImage() async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();

    if (pickedFiles != null) {
      setState(() {
        _imageFiles.addAll(pickedFiles);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diary_Write'),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircularBackButton(
              iconSize: 20,
              onPressed: () {
                //todo context.pop()하면 There is nothing to pop 에러. -> 이전 화면에서 go 방식에서 push 방식으로 변경.
                context.pop();
                // context.pop('value');
              }),
        ),
      ),
      body: Padding(
        padding: Theme.of(context).paddingHorizontal20Vertical10,
        child: ListView(
          children: [
            CustomBorderContainer(
              width: double.infinity,
              height: 300.h,
              backgroundColor: AppColors.followButtonColor,
              borderColor: Colors.black,
              borderWidth: 1,
              child: Padding(
                padding: Theme.of(context).paddingHorizontal20Vertical10,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 20.w,
                              height: 20.h,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            SizedBox(width: 10.w),
                            Text('Your Memories'),
                          ],
                        ),
                        IconButton(
                          onPressed: _pickImage,
                          icon: Icon(Icons.add),
                        ),
                      ],
                    ),
                    SizedBox(height: 25.h),
                    _imageFiles.isEmpty
                        ? GestureDetector(
                            //todo 업로드 취소시 메세지 처리
                            onTap: _pickImage,
                            child: SizedBox(
                              height: 200.h,
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Image.asset('assets/big-image-2.png')),
                            ),
                          )
                        : Column(
                            children: [
                              CarouselSlider(
                                items: _imageFiles.map((file) {
                                  return Builder(
                                      builder: (BuildContext context) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      width: 350.w,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5.0),
                                      child: Image.file(
                                        File(file.path),
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  });
                                }).toList(),
                                options: CarouselOptions(
                                  height: 150.h,
                                  enlargeCenterPage: true,
                                  enableInfiniteScroll: false,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _currentPicture = index;
                                    });
                                  },
                                ),
                                carouselController: _carouselSliderController,
                              ),
                              SizedBox(height: 25.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:
                                    _imageFiles.asMap().entries.map((entry) {
                                  return GestureDetector(
                                    onTap: () {
                                      _carouselSliderController
                                          .animateToPage(entry.key);
                                    },
                                    child: Container(
                                      width: 12.w,
                                      height: 12.h,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 4.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _currentPicture == entry.key
                                            ? AppColors.growingTalesGreen
                                            : Colors.grey,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            CustomBorderContainer(
              width: double.infinity,
              height: 350.h,
              backgroundColor: AppColors.growingTalesPink,
              borderWidth: 1,
              borderColor: Colors.black,
              child: Padding(
                padding: Theme.of(context).paddingHorizontal20Vertical10,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 20.w,
                              height: 20.h,
                              decoration: BoxDecoration(
                                  color: AppColors.followButtonColor,
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            SizedBox(width: 10.w),
                            Text('Your Diary'),
                          ],
                        ),
                      ],
                    ),
                    // TextField(
                    //   decoration: InputDecoration(
                    //     hintText: 'Enter your text here',
                    //     border: InputBorder.none,
                    //   ),
                    //   style: Theme.of(context).textTheme.bodySmall,
                    //   maxLines: null,
                    // ),
                    Expanded(child: CustomStyledTextField()),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40.h),
            // Container(height: 2, width: double.infinity, color: Colors.black),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 20.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                              color: AppColors.followButtonColor,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        SizedBox(width: 10.w),
                        Text('Books'),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.filter_alt),
                      onPressed: _toggleTopView,
                    ),
                    Icon(Icons.search),
                  ],
                ),
                SizedBox(height: 20.h),
                BookListSection(showOnlyTop: _showOnlyTop),
              ],
            ),
            SizedBox(height: 40.h),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 20.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                              color: AppColors.followButtonColor,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        SizedBox(width: 10.w),
                        Text('Settings'),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(height: 10.w),
                      Row(
                        children: [
                          Container(
                            width: 20.w,
                            height: 20.h,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          SizedBox(width: 10.w),
                          Text('Choose public option'),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Container(
                            width: 20.w,
                            height: 20.h,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          SizedBox(width: 10.w),
                          Text('show your Name'),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Container(
                            width: 20.w,
                            height: 20.h,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          SizedBox(width: 10.w),
                          Text('Show your Region'),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () {}, child: Text('Delete')),
                          ),
                          SizedBox(width: 30.w),
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () {}, child: Text('Save')),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
