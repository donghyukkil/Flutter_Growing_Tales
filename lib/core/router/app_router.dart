import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../ui/views/community_screen.dart';
import '../../ui/views/follows_screen.dart';
import '../../ui/views/landing_screen.dart';
import '../../ui/views/profile_screen.dart';
import '../../ui/views/statistics_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/statistics',
    routes: [
      GoRoute(
        path: '/statistics',
        builder: (context, state) => const StatisticsScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/follows',
        builder: (context, state) => const FollowsScreen(),
      ),
      GoRoute(
        path: '/community',
        builder: (context, state) => const CommunityScreen(),
      ),
      GoRoute(
        path: '/landing',
        builder: (context, state) => const LandingPage(),
      ),
    ],
  );
}
