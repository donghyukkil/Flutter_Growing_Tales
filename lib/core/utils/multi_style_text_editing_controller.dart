import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'text_helpers.dart';

class MultiStyleTextEditingController extends TextEditingController {
  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    final List<TextSpan> spans = [];

    for (int i = 0; i < text.length; i++) {
      final String char = text[i];
      final TextStyle charStyle =
          getAppropriateTextStyle(char, context).copyWith(
        fontSize: 18.sp,
      );

      spans.add(
        TextSpan(
          text: char,
          style: charStyle,
        ),
      );
    }

    return TextSpan(children: spans, style: style);
  }
}
