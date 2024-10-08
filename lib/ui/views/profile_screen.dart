import 'package:flutter/material.dart';

import '../../core/theme/custom_theme_extension.dart';
import '../components/profile_section.dart';
import '../components/tag_section.dart';
import '../components/latest_diary_section.dart';
import '../../core/widgets/custom_bottom_navigation_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  //todo: 전체 스크롤로 바꾸기, singgleScroll이 안좋은 이유,
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
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
