import 'package:flutter/material.dart';

import '../../core/utils/text_helpers.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const CustomText({
    super.key,
    required this.text,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final defaultStyle = getAppropriateTextStyle(text, context);
    final effectiveStyle =
        style != null ? defaultStyle.merge(style) : defaultStyle;

    return Text(
      text,
      style: effectiveStyle,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }
}
