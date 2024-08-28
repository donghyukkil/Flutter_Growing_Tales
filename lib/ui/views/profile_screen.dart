import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_constants.dart';
import '../components/custom_bottom_navigation_bar.dart';
import '../components/profile_section.dart';
import '../components/tag_section.dart';
import '../components/latest_diary_section.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: AppConstants.designSize,
      builder: (context, child) {
        return MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: Text(
                'Profile',
                style: AppConstants.headingStyle,
              ),
              backgroundColor: Colors.white,
              leading: Padding(
                padding: AppConstants.paddingAll12,
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              actions: [
                Padding(
                  padding: AppConstants.paddingAll12,
                  child: Icon(
                    Icons.notifications,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            body: Padding(
              padding: AppConstants.paddingHorizontal20wVertical10h(),
              child: Column(
                children: [
                  ProfileSection(),
                  LatestDiarySection(),
                  TagSection(),
                ],
              ),
            ),
            bottomNavigationBar: CustomBottomNavigationBar(),
          ),
        );
      },
    );
  }
}
