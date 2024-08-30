import 'package:flutter/material.dart';

import '../../core/theme/custom_theme_extension.dart';
import '../components/profile_section.dart';
import '../components/tag_section.dart';
import '../components/latest_diary_section.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Theme.of(context).paddingHorizontal20Vertical10,
      child: Column(
        children: [
          ProfileSection(),
          LatestDiarySection(),
          TagSection(),
        ],
      ),
    );
  }
}
