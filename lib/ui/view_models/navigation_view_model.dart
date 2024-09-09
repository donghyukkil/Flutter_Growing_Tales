//This ViewModel keeps track of the current index and provides a way to update it.

import 'package:flutter/material.dart';

class NavigationViewModel extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void onTapTapped(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
