import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFollowButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final double borderRadius;
  final double borderWidth;

  const CustomFollowButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = 90.0,
    this.height = 25.0,
    this.backgroundColor = Colors.transparent,
    this.textColor = Colors.black,
    this.borderColor = Colors.black,
    this.borderRadius = 10.0,
    this.borderWidth = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 4.h,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(
          borderRadius,
        ),
        border: Border(
          top: BorderSide(
            color: borderColor,
            width: borderWidth,
          ),
          left: BorderSide(
            color: borderColor,
            width: borderWidth,
          ),
          right: BorderSide(
            color: borderColor,
            width: borderWidth,
          ),
          bottom: BorderSide(
            color: borderColor,
            width: borderWidth + 3,
          ),
        ),
      ),
      child: SizedBox(
        width: width.w,
        height: height.h,
        child: ElevatedButton(
          style: ButtonStyle(
            padding: WidgetStateProperty.all(
              EdgeInsets.symmetric(
                horizontal: 2.w,
                vertical: 2.h,
              ),
            ),
            backgroundColor: WidgetStateProperty.all(
              Colors.transparent,
            ),
            elevation: WidgetStateProperty.all(
              0,
            ),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ),
    );
  }
}
