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

  //todo 해당 페이지 접속 시 혹은 스크롤 내리면 다시 데이터 가져오기. 무한 스크롤 구현하기. 캐싱도 고려
//todo firebase에 없는 userName userRegion 등 업데이트하는 셋팅 페이지 만들기. 라디오 버튼으로 isPublic도 함께.
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final diaryViewModel = context.read<DiaryViewModel>();
      if (!diaryViewModel.state.isLoading &&
          diaryViewModel.state.allDiariesWithUser.isEmpty) {
        diaryViewModel.fetchAllDiaries();
      }
    });

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
                  Expanded(child: Consumer<DiaryViewModel>(
                    builder: (context, diaryViewModel, child) {
                      final diariesWithUser = context
                          .watch<DiaryViewModel>()
                          .state
                          .allDiariesWithUser;

                      if (diaryViewModel.state.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (diariesWithUser.isEmpty) {
                        return const Center(
                          child: Text('No Diaries Found'),
                        );
                      }

                      return ListView.builder(
                        itemCount: diariesWithUser.length,
                        itemBuilder: (context, index) {
                          final diaryWithUser = diariesWithUser[index];

                          return UserDiaryTile(
                            imageUrl: diaryWithUser.diary.imageUrls.isNotEmpty
                                ? diaryWithUser.diary.imageUrls.first
                                : '',
                            name: diaryWithUser.userName,
                            region: diaryWithUser.userRegion,
                            diaryContent: diaryWithUser.diary.content,
                            onFollowPressed: () {
                              Logger.info('Follow button pressed');
                            },
                          );
                        },
                      );
                    },
                  )),
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
