import 'package:flutter/material.dart';
import 'package:growing_tale/core/theme/custom_theme_extension.dart';

import '../../core/widgets/custom_bottom_navigation_bar.dart';
import '../components/profile_section.dart';
import '../components/tag_section.dart';
import '../components/latest_diary_section.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
        ),
        leading: Padding(
          padding: Theme.of(context).paddingAll12,
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: Theme.of(context).paddingAll12,
            child: Icon(
              Icons.notifications,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Padding(
        padding: Theme.of(context).paddingHorizontal20Vertical10,
        child: Column(
          children: [
            ProfileSection(),
            LatestDiarySection(),
            TagSection(),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
