import 'package:flutter/material.dart';

import '../../core/widgets/custom_text.dart';

void showSettingsMenu({
  required BuildContext context,
  required GlobalKey settingsKey,
  required List<String> menuItems,
  required Function(String) onSelected,
}) {
  // Note: Retrives the RenderBox of the row using the GlobalKey.
  final RenderBox renderBox =
      settingsKey.currentContext!.findRenderObject() as RenderBox;

  // Note: calculate the global position of the top-left corner of the RnederBox.
  // Note: localToGlobal converts local widget coordinates to global screen coordinates.
  final Offset position = renderBox.localToGlobal(Offset.zero);

  final Size size = renderBox.size;

  showMenu(
          context: context,
          position: RelativeRect.fromLTRB(
            position.dx,
            position.dy + size.height,
            position.dx,
            position.dy,
          ),
          items: menuItems.map((item) {
            return PopupMenuItem(
              value: item,
              child: Align(
                child: CustomText(
                  text: item,
                ),
              ),
            );
          }).toList())
      .then((value) {
    if (value != null) {
      onSelected(value);
    }
  });
}
