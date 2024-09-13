import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/controllers/multi_style_text_editing_controller.dart';

class CustomStyledTextField extends StatefulWidget {
  const CustomStyledTextField({super.key});

  @override
  State<CustomStyledTextField> createState() => _CustomStyledTextFieldState();
}

class _CustomStyledTextFieldState extends State<CustomStyledTextField> {
  late MultiStyleTextEditingController _titleController;
  late MultiStyleTextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = MultiStyleTextEditingController();
    _contentController = MultiStyleTextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _titleController,
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
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text('Title'),
                  ],
                )),
            // labelText: 'Title',
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
          controller: _contentController,
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
                        color: Colors.black,
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
