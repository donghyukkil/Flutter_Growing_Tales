import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/core/theme/app_theme.dart';
import '../ui/views/landing_screen.dart';
import '../ui/views/profile_screen.dart';
import '../ui/views/follows_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(
          375,
          812,
        ),
        builder: (context, child) {
          return MaterialApp(
            title: 'GrowingTales',
            theme: AppTheme.lightTheme,
            home: ProfileScreen(),
          );
        });
  }
}
