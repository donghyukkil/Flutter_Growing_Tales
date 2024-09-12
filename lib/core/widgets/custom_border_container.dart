import 'package:flutter/material.dart';

class CustomBorderContainer extends StatelessWidget {
  final double width;
  final double height;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final Widget? child;

  const CustomBorderContainer({
    super.key,
    required this.width,
    required this.height,
    required this.backgroundColor,
    required this.borderColor,
    required this.borderWidth,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
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
            width: borderWidth * 5,
          ),
        ),
      ),
      child: child,
    );
  }
}
