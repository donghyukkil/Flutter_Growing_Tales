import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/custom_theme_extension.dart';
import '../../core/widgets/user_info_tile.dart';
import '../../core/widgets/custom_bottom_navigation_bar.dart';
import '../../data/models/user/user.dart';
import '../../ui/view_models/users_view_model.dart';
import '../../ui/view_models/diary_view_model.dart';
import '../../ui/components/user_diary_tile.dart';
import '../../core/utils/logger.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Community')),
      body: Padding(
        padding: Theme.of(context).paddingHorizontal20Vertical10,
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Consumer<UsersViewModel>(
                    builder: (context, userViewModel, child) {
                      // final currentUser = userViewModel.currentUser;

                      final user = userViewModel.state.user;
                      return UserInfoTile(
                        imageUrl: user?.imageUrl ?? 'assets/dummy1.png',
                        name: user?.name ?? 'Login plz',
                        region: user?.region ?? 'Find your loves',
                        buttonText: user == null ? 'Login' : 'Logout',
                        onButtonPressed: () {
                          if (user == null) {
                            // context.go('/landing');
                            context.push('/landing');
                          } else {
                            userViewModel.logout(context);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Logged out successfully,'),
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Expanded(
                    child: Consumer<DiaryViewModel>(
                      builder: (context, diaryViewModel, child) {
                        final diaries =
                            context.read<DiaryViewModel>().state.allDiaries;

                        // Fetch all diaries only once using addPostFrameCallback
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (diaries.isEmpty) {
                            diaryViewModel.fetchAllDiaries();
                          }
                        });

                        if (diaryViewModel.state.isLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (diaries.isEmpty) {
                          return const Center(
                            child: Text('No Diaries Found'),
                          );
                        }

                        return Scrollbar(
                          child: ListView.builder(
                            itemCount: diaries.length,
                            itemBuilder: (context, index) {
                              final diary = diaries[index];

                              return FutureBuilder<User?>(
                                future: context
                                    .read<UsersViewModel>()
                                    .getUserById(diary.userId),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Container();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else if (snapshot.hasData) {
                                    final user = snapshot.data;
                                    final userName =
                                        user?.name ?? 'Unknown User';
                                    final userRegion =
                                        user?.region ?? 'Unknown Region';

                                    return UserDiaryTile(
                                      imageUrl: diary.imageUrl,
                                      name: userName,
                                      region: userRegion,
                                      diaryContent: diary.content,
                                      onFollowPressed: () {
                                        Logger.info('Follow button pressed');
                                      },
                                    );
                                  } else {
                                    return const Text('User not found');
                                  }
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
