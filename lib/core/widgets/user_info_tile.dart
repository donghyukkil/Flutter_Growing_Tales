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
      padding: EdgeInsets.only(
        bottom: 10.0.h,
      ),
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
                width: 2.w,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                    ),
                    Text(
                      region,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 15.w,
              ),
              CustomFollowButton(
                text: buttonText,
                onPressed: onButtonPressed,
                width: 40.w,
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
