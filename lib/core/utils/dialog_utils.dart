import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';
import '../../core/widgets/custom_text.dart';

void showCustomDialog({
  required BuildContext context,
  required String title,
  required String content,
  required Future<void> Function()? onSettingsPressed,
  required String settingsButtonText,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        backgroundColor: AppColors.dialogBackgroundColor,
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.black, width: 2.w),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: title,
                style: TextStyle(fontSize: 25.sp),
              ),
              SizedBox(height: 10.h),
              CustomText(text: content, style: TextStyle(fontSize: 15.sp)),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //todo customButton 만들어서 수정
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: CustomText(
                      text: '취소',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  TextButton(
                    onPressed: () async {
                      if (onSettingsPressed != null) {
                        await onSettingsPressed();
                      }
                    },
                    child: CustomText(
                      text: settingsButtonText,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
