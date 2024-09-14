import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:growing_tales/core/utils/logger.dart';
import 'package:image_picker/image_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/controllers/multi_style_text_editing_controller.dart';
import '../../core/widgets/circular_back_button.dart';
import '../../core/theme/custom_theme_extension.dart';
import '../../core/widgets/custom_border_container.dart';
import '../../core/widgets/custom_styled_text_field.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_checkbox.dart';
import '../../core/utils/image_utils.dart';
import '../../ui/components/book_list_section.dart';
import '../../ui/view_models/diary_view_model.dart';

class DiaryWriteScreen extends StatefulWidget {
  const DiaryWriteScreen({super.key});

  @override
  State<DiaryWriteScreen> createState() => _DiaryWriteScreenState();
}

//todo flutter_image_compress, 이미지 변환, path_provider
// 이미지 저장 시 google storage에 저장하고 이미지 경로만 firestore에 저장
// 코드 평가
// 이미지 커스텀 보더 설정.
//todo 사용자가 TextField에 긴 글을 복사하면 overFollow 에러 발생.

class _DiaryWriteScreenState extends State<DiaryWriteScreen> {
  // Variables for managing widget state
  int _currentPicture = 0;
  bool _showOnlyTop = true;
  final CarouselSliderController _carouselSliderController =
      CarouselSliderController();

  // Variables used for saving data to FireStore via diaryViewmodel.
  bool _isPublic = false;
  bool _showName = false;
  bool _showRegion = false;
  final List<String> _selectedBooks = [];
  final List<XFile> _imageFiles = [];
  final List<String> _imagePaths = [];
  final MultiStyleTextEditingController _titleController =
      MultiStyleTextEditingController();
  final MultiStyleTextEditingController _contentController =
      MultiStyleTextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _toggleTopView() {
    setState(() {
      _showOnlyTop = !_showOnlyTop;
    });
  }

  Future<void> _pickImage() async {
    final images = await pickImages(context);

    if (images.isNotEmpty) {
      setState(() {
        _imageFiles.addAll(images);
      });
    }
  }

  void _saveEntry() async {
    //todo: Question: Provider.of(listen: false) 사용. save 버튼 누르면 viewModel 메서드 호출하고 페이지 이동할건데. 즉, UI 업데이트가 불필요한데, Consumer 사용을 고려할 필요가 잇을까?
    final diaryViewModel = Provider.of<DiaryViewModel>(context, listen: false);

    final settings = {
      'publicOption': _isPublic,
      'showName': _showName,
      'showRegion': _showRegion,
    };

    _imagePaths.clear();

    try {
      //description: image_picker: XFILE. <-> dart:io : File.

      final uploadTasks = _imageFiles.map((imageFile) async {
        File file = File(imageFile.path); // XFile -> File.
        File compressedImage = await compressImage(file);
        String imageUrl = await diaryViewModel.uploadImage(compressedImage);

        return imageUrl;
      }).toList();

      _imagePaths.addAll(await Future.wait(uploadTasks));

      diaryViewModel.saveDiaryEntry(
        imageFiles: _imagePaths,
        title: _titleController.text,
        contents: _contentController.text,
        selectedBooks: _selectedBooks,
        settings: settings,
      );

      context.go('/statistics');
    } catch (e) {
      Logger.error('Error saving diary entry: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Failed to save diary entry. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diary_Write'),
        leading: Padding(
          padding: const EdgeInsets.all(8),
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
              // backgroundColor: AppColors.followButtonColor,
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
              // backgroundColor: AppColors.growingTalesPink,
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
                        child: CustomStyledTextField(
                      titleController: _titleController,
                      contentController: _contentController,
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
                            isChecked: _isPublic,
                            onChanged: (bool newValue) {
                              setState(() {
                                _isPublic = newValue;
                              });
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
                            isChecked: _showName,
                            onChanged: (bool newValue) {
                              setState(() {
                                _showName = newValue;
                              });
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
                            isChecked: _showRegion,
                            onChanged: (bool newValue) {
                              setState(() {
                                _showRegion = newValue;
                              });
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
                          Expanded(
                            child: CustomButton(
                              onPressed: () {},
                              title: 'Delete',
                              backGroundColor: Colors.white,
                              textColor: Colors.black,
                            ),
                          ),
                          SizedBox(width: 30.w),
                          Expanded(
                            child: CustomButton(
                              onPressed: _saveEntry,
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
