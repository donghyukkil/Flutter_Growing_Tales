import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_constants.dart';

class SocialLoginButton extends StatelessWidget {
  final String assetPath;
  final String text;
  final Color backgroundColor;
  final VoidCallback onPressed;
  final BoxFit imageFit;
  final TextStyle? textStyle;

  const SocialLoginButton({
    super.key,
    required this.assetPath,
    required this.text,
    required this.backgroundColor,
    required this.onPressed,
    required this.imageFit,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 195.w,
      child: ConstrainedBox(
        // Ensuring the button meets Apple's minimum size requirements (140pt width, 30pt height).
        constraints: BoxConstraints(minWidth: 140.w, minHeight: 30.h),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r)),
          ),
          child: Row(
            children: [
              Container(
                width: 20.w,
                height: 40.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(assetPath),
                    fit: imageFit,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                text,
                style: textStyle ?? AppConstants.googleStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
