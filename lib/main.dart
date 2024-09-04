import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'core/config/firebase_options.dart';
import '/core/theme/app_theme.dart';
import '/core/widgets/custom_bottom_navigation_bar.dart';
import 'ui/views/statistics_screen.dart';
import 'ui/views/landing_screen.dart';
import 'ui/views/profile_screen.dart';
import 'ui/views/follows_screen.dart';
import 'ui/views/community_screen.dart';
import 'ui/view_models/users_view_model.dart';

void main() async {
  // Firebase 초기화를 위해 Flutter 엔진을 미리 준비
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => UsersViewModel(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    StatisticsScreen(),
    ProfileScreen(),
    FollowsScreen(),
    CommunityScreen(),
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
              title: Text(
                'Growing Tales',
              ),
            ),
            body: _pages[_currentIndex],
            bottomNavigationBar: CustomBottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: _onTabTapped,
            ),
            floatingActionButton: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(
                        0,
                        2.5,
                      ),
                      blurRadius: 2.0,
                      spreadRadius: 1.0,
                    )
                  ]),
              child: FloatingActionButton(
                onPressed: () {
                  print(
                    'Create new diary',
                  );
                },
                backgroundColor: Colors
                    .transparent, // Set to transparent to show custom color
                elevation: 0, // Remove default FAB shadow
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
