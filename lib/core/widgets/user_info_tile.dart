import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/custom_circle_avatar.dart';
import '../widgets/custom_follow_button.dart';
import '../widgets/custom_text.dart';
import '../constants/app_colors.dart';

class UserInfoTile extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String region;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final bool showBorder;

  const UserInfoTile({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.region,
    required this.buttonText,
    required this.onButtonPressed,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Container(
        height: 100.h,
        decoration: BoxDecoration(
          border: showBorder
              ? Border(
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
                )
              : null,
          borderRadius: BorderRadius.circular(
            (10.r),
          ),
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 15.w),
            CustomCircleAvatar(
              imageUrl: imageUrl,
              size: 80.r,
            ),
            SizedBox(
              width: 15.w,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: name,
                    style: TextStyle(fontSize: 20.sp),
                  ),
                  CustomText(
                    text: region,
                    style: TextStyle(fontSize: 15.sp),
                  ),
                ],
              ),
            ),
            CustomFollowButton(
              text: buttonText,
              onPressed: onButtonPressed,
              width: 40.w,
              height: 30.h,
              backgroundColor: AppColors.followButtonColor,
              textColor: Colors.black,
              borderColor: Colors.black,
              borderRadius: 10.r,
              borderWidth: 2.w,
            ),
            SizedBox(width: 15.w),
          ],
        ),
      ),
    );
  }
}
