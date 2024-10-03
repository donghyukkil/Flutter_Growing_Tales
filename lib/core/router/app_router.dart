import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:growing_tales/ui/views/books/book_search_screen.dart';

import '../../data/models/diary/diary_with_user.dart';
import '../../ui/views/community_screen.dart';
import '../../ui/views/follows_screen.dart';
import '../../ui/views/landing_screen.dart';
import '../../ui/views/profile_screen.dart';
import '../../ui/views/statistics_screen.dart';
import '../../ui/views/diary/diary_detail_screen.dart';
import '../../ui/views/diary/diary_write_screen.dart';

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
        // builder: (context, state) => const ProfileScreen(),
        builder: (context, state) => const BookSearchScreen(),
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
          final diaryObject = state.extra; // 전달된 데이터를 가져옴

          // diaryObject가 DiaryWithUser일 경우와 Diary일 경우를 구분해서 처리
          if (diaryObject is DiaryWithUser) {
            return DiaryDetailScreen(diaryObject: diaryObject);
          } else if (diaryObject is Diary) {
            return DiaryDetailScreen(diaryObject: diaryObject);
          } else {
            return Scaffold(
              body: Center(
                child: Text('Invalid data passed to diary detail'),
              ),
            );
          }
        },
      ),
    ],
  );
}
