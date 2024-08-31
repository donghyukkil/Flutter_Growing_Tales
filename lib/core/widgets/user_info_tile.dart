import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/custom_circle_avatar.dart';
import '../widgets/custom_follow_button.dart';

class UserInfoTile extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String region;
  final String buttonText;
  final VoidCallback onButtonPressed;

  const UserInfoTile({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.region,
    required this.buttonText,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0.h,
      ),
      child: Container(
        height: 100.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2.w,
          ),
          borderRadius: BorderRadius.circular(
            (10.r),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(
            15.0.w,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomCircleAvatar(
                imageUrl: imageUrl,
                size: 80.r,
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      region,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 13.sp,
                          ),
                    ),
                  ],
                ),
              ),
              CustomFollowButton(
                text: buttonText,
                onPressed: onButtonPressed,
                width: 60.w,
                height: 30.h,
                backgroundColor: Color(
                  0xFFFFBD11,
                ),
                textColor: Colors.black,
                borderColor: Colors.black,
                borderRadius: 10.r,
                borderWidth: 2.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
