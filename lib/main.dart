import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/core/theme/app_theme.dart';
import '../ui/views/landing_screen.dart';
import '../ui/views/profile_screen.dart';
import '../ui/views/follows_screen.dart';
import '/core/widgets/custom_bottom_navigation_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    LandingPage(),
    ProfileScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

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
            home: Scaffold(
              appBar: AppBar(
                title: Text('Growing Tales'),
              ),
              body: _pages[_currentIndex],
              bottomNavigationBar: CustomBottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: _onTabTapped,
              ),
            ),
          );
        });
  }
}
