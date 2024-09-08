import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

bool isKorean(String text) {
  final koreanRegex = RegExp(r'[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]');

  return koreanRegex.hasMatch(text);
}

TextStyle getAppropriateTextStyle(String text, BuildContext context) {
  return isKorean(text)
      ? AppConstants.koreanStyleBodySmall
      : Theme.of(context).textTheme.bodySmall!;
}
