import 'package:flutter/material.dart';
import '../ui/views/landing_screen.dart';
import '../ui/views/profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileScreen();
  }
}
