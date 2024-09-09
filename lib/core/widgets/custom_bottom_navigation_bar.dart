import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../ui/view_models/navigation_view_model.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationViewModel = context.watch<NavigationViewModel>();

    return BottomNavigationBar(
      currentIndex: navigationViewModel.currentIndex,
      onTap: (index) {
        navigationViewModel.onTapTapped(index);
        switch (index) {
          case 0:
            context.go('/statistics');
            break;
          case 1:
            context.go('/profile');
            break;
          case 2:
            context.go('/follows');
            break;
          case 3:
            context.go('/community');
            break;
          case 4:
            context.go('/landing');
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            color: Colors.black,
            Icons.home,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(color: Colors.black, Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(color: Colors.black, Icons.people),
          label: 'Follows',
        ),
        BottomNavigationBarItem(
          icon: Icon(color: Colors.black, Icons.forum),
          label: 'Community',
        ),
      ],
    );
  }
}
