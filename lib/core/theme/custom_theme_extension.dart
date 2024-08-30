import 'package:flutter/material.dart';

extension CustomTheme on ThemeData {
  EdgeInsets get paddingHorizontal20Vertical10 => EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      );

  EdgeInsets get paddingAll12 => EdgeInsets.all(12);
}
