import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:growing_tales/core/constants/app_colors.dart';

import '../utils/multi_style_text_editing_controller.dart';

class CustomStyledTextField extends StatefulWidget {
  final MultiStyleTextEditingController titleController;
  final MultiStyleTextEditingController contentController;

  const CustomStyledTextField({
    super.key,
    required this.titleController,
    required this.contentController,
  });

  @override
  State<CustomStyledTextField> createState() => _CustomStyledTextFieldState();
}

class _CustomStyledTextFieldState extends State<CustomStyledTextField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: widget.titleController,
          maxLines: 1,
          style: TextStyle(
            height: 1.2,
            fontSize: 18.sp,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            label: SizedBox(
                width: double.infinity,
                height: 30.h,
                child: Row(
                  children: [
                    Container(
                      width: 20.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        color: AppColors.growingTalesRed,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text('Title'),
                  ],
                )),
            border: InputBorder.none,
            hintText: 'Enter title here',
            contentPadding:
                EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
          ),
          cursorColor: Colors.black,
          cursorHeight: 20,
          cursorWidth: 1.5,
        ),
        TextField(
          controller: widget.contentController,
          maxLines: null,
          style: TextStyle(
            height: 1.2,
            fontSize: 16.sp,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            label: SizedBox(
                width: double.infinity,
                height: 30.h,
                child: Row(
                  children: [
                    Container(
                      width: 20.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        color: AppColors.growingTalesBlue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text('Contents'),
                  ],
                )),
            border: InputBorder.none,
            hintText: 'Enter content here',
            contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
          ),
          cursorColor: Colors.black,
          cursorHeight: 20,
          cursorWidth: 1.5,
        ),
      ],
    );
  }
}
