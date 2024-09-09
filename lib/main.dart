import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'core/config/firebase_options.dart';
import '/core/theme/app_theme.dart';
import 'core/utils/logger.dart';
import 'ui/views/statistics_screen.dart';
import 'providers/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Logger.info('Initializing Firebase...');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Logger.info('Firebase initialized successfully.');

  runApp(MultiProvider(
    providers: appProviders,
    child: const MyApp(),
  ));
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
          home: Scaffold(
            body: StatisticsScreen(),
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
