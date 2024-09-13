import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/widgets/custom_text.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Color backGroundColor;
  final Color textColor;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.title,
    required this.backGroundColor,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backGroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: Colors.black, width: 2),
        ),
      ),
      onPressed: onPressed,
      child: CustomText(
        text: title,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 25.sp,
        ),
      ),
    );
  }
}
