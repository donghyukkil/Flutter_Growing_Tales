import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black), label: 'home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart, color: Colors.black),
            label: 'bar_chart'),
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, color: Colors.black),
            label: 'calendar_today'),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: Colors.black), label: 'settings'),
      ],
    );
  }
}
