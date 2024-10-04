import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/multi_style_text_editing_controller.dart';
import '../../../core/utils/dialog_utils.dart';
import '../../../core/utils/logger.dart';
import '../../../core/widgets/circular_back_button.dart';
import '../../../core/theme/custom_theme_extension.dart';
import '../../../core/widgets/custom_border_container.dart';
import '../../../core/widgets/custom_styled_text_field.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_checkbox.dart';
import '../../../core/utils/image_utils.dart';
import '../../../ui/components/book_list_section.dart';
import '../../../ui/view_models/diary_view_model.dart';

class DiaryWriteScreen extends StatefulWidget {
  const DiaryWriteScreen({super.key});

  @override
  State<DiaryWriteScreen> createState() => _DiaryWriteScreenState();
}

// 이미지 커스텀 보더 설정.

class _DiaryWriteScreenState extends State<DiaryWriteScreen> {
  // Variables for managing widget state
  int _currentPicture = 0;
  bool _showOnlyTop = true;
  final List<String> _selectedBooks = [];
  Timer? _debounce;

  final CarouselSliderController _carouselSliderController =
      CarouselSliderController();
  final MultiStyleTextEditingController _titleController =
      MultiStyleTextEditingController();
  final MultiStyleTextEditingController _contentController =
      MultiStyleTextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.addListener(_resetSaveFlag);
    _contentController.addListener(_resetSaveFlag);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSavePressed() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(seconds: 2), () {
      _saveEntry();
    });
  }

  void _toggleTopView() {
    setState(() {
      _showOnlyTop = !_showOnlyTop;
    });
  }

  void _resetSaveFlag() {
    Provider.of<DiaryViewModel>(context, listen: false).resetSaveFlag();
  }

  Future<void> _pickImage() async {
    Provider.of<DiaryViewModel>(context, listen: false).clearImages();

    final images = await pickImages(context);

    if (images.isNotEmpty) {
      Provider.of<DiaryViewModel>(context, listen: false).addImages(images);
    }
  }

  void _saveEntry() async {
    final diaryViewModel = Provider.of<DiaryViewModel>(context, listen: false);

    final settings = {
      'publicOption': diaryViewModel.state.isPublic,
      'showName': diaryViewModel.state.showName,
      'showRegion': diaryViewModel.state.showRegion,
    };

    try {
      diaryViewModel.saveEntry(
        title: _titleController.text,
        contents: _contentController.text,
        selectedBooks: _selectedBooks,
        settings: settings,
        onSuccess: () {
          showCustomDialog(
            context: context,
            title: 'Success',
            content: 'Your diary entry has been saved successfully!',
            onSettingsPressed: () async {
              diaryViewModel.resetState();
              context.go('/statistics');
            },
            settingsButtonText: 'Ok',
          );
        },
        onError: (errorMessage) {
          showCustomDialog(
            context: context,
            title: 'Error',
            content: errorMessage,
            onSettingsPressed: () async {
              diaryViewModel.resetState();
              context.go('/statistics');
            },
            settingsButtonText: '확인',
          );
        },
      );
    } catch (e) {
      Logger.error('Error saving diary entry: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final diaryViewModel = Provider.of<DiaryViewModel>(context);
    final state = diaryViewModel.state;

    return Scaffold(
      appBar: AppBar(
        title: Text('Diary_Write'),
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: CircularBackButton(
              iconSize: 20,
              onPressed: () {
                diaryViewModel.resetState();
                context.go('/statistics');
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
              backgroundColor: Colors.white,
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
                    state.imageFiles.isEmpty
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
                                items: state.imageFiles.map((file) {
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
                                children: state.imageFiles
                                    .asMap()
                                    .entries
                                    .map((entry) {
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
              backgroundColor: Colors.white,
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
                    Expanded(
                        child: SingleChildScrollView(
                      child: CustomStyledTextField(
                        titleController: _titleController,
                        contentController: _contentController,
                      ),
                    )),
                  ],
                ),
              ),
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
                              color: AppColors.growingTalesPink,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        SizedBox(width: 10.w),
                        Text('Books'),
                        _showOnlyTop == true
                            ? IconButton(
                                iconSize: 30.0,
                                icon: Icon(Icons.keyboard_arrow_right_outlined),
                                onPressed: _toggleTopView,
                              )
                            : IconButton(
                                iconSize: 30.0,
                                icon: Icon(Icons.keyboard_arrow_down_outlined),
                                onPressed: _toggleTopView,
                              )
                      ],
                    ),
                    Icon(Icons.search),
                  ],
                ),
                SizedBox(height: 10.h),
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
                              color: AppColors.growingTalesGreen,
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
                          CustomCheckbox(
                            isChecked: state.isPublic,
                            onChanged: (bool newValue) {
                              diaryViewModel.togglePublicOption(newValue);
                            },
                            checkColor: AppColors.followButtonColor,
                            uncheckedColor: Colors.white,
                            borderColor: Colors.black,
                          ),
                          SizedBox(width: 10.w),
                          Text('Choose public option'),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          CustomCheckbox(
                            isChecked: state.showName,
                            onChanged: (bool newValue) {
                              diaryViewModel.toggleShowName(newValue);
                            },
                            checkColor: AppColors.followButtonColor,
                            uncheckedColor: Colors.white,
                            borderColor: Colors.black,
                          ),
                          SizedBox(width: 10.w),
                          Text('Show your Name'),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          CustomCheckbox(
                            isChecked: state.showRegion,
                            onChanged: (bool newValue) {
                              diaryViewModel.toggleShowRegion(newValue);
                            },
                            checkColor: AppColors.followButtonColor,
                            uncheckedColor: Colors.white,
                            borderColor: Colors.black,
                          ),
                          SizedBox(width: 10.w),
                          Text('Show your Region'),
                        ],
                      ),
                      SizedBox(height: 50.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //todo save 버튼 한번 만다르게 수정.
                          //todo 로딩 인디케이터.
                          Expanded(
                            child: CustomButton(
                              onPressed: _onSavePressed,
                              title: 'Save',
                              backGroundColor: Colors.black,
                              textColor: Colors.white,
                            ),
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
