import 'package:flutter/material.dart';

class CircularBackButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double iconSize;

  const CircularBackButton({
    super.key,
    required this.onPressed,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      child: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: onPressed,
        iconSize: iconSize,
      ),
    );
  }
}
