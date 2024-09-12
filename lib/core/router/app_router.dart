import 'package:go_router/go_router.dart';

import '../../ui/views/community_screen.dart';
import '../../ui/views/follows_screen.dart';
import '../../ui/views/landing_screen.dart';
import '../../ui/views/profile_screen.dart';
import '../../ui/views/statistics_screen.dart';
import '../../ui/views/diary_detail_screen.dart';
import '../../ui/views/diary_write_screen.dart';

import '../../data/models/diary/diary.dart';

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
      GoRoute(
        path: '/diary/write',
        builder: (context, state) => const DiaryWriteScreen(),
      ),
      GoRoute(
        path: '/diary_detail',
        builder: (context, state) {
          final diary = state.extra as Diary; // Cast the passed data
          return DiaryDetailScreen(diary: diary);
        },
      ),
    ],
  );
}
