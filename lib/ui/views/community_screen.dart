import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../core/theme/custom_theme_extension.dart';
import '../../core/widgets/user_info_tile.dart';
import '../../core/utils/dialog_utils.dart';
import '../../data/dummy_data.dart';
import '../../data/models/user.dart';
import '../../ui/view_models/users_view_model.dart';
import '../../ui/view_models/diary_view_model.dart';
import '../../ui/components/user_diary_tile.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Theme.of(context).paddingHorizontal20Vertical10,
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Consumer<UsersViewModel>(
                  builder: (context, userViewModel, child) {
                    final currentUser = userViewModel.currentUser;

                    return UserInfoTile(
                      imageUrl: currentUser?.imageUrl ?? dummyUsers[0].imageUrl,
                      name: currentUser?.name ?? dummyUsers[0].name,
                      region: currentUser?.region ?? dummyUsers[0].region,
                      buttonText: currentUser == null ? 'Login' : 'Logout',
                      onButtonPressed: () {
                        if (currentUser == null) {
                          showCustomDialog(context);
                        } else {
                          userViewModel.logout();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Logged out successfully.'),
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
                        return const Center(child: CircularProgressIndicator());
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
                                  final userName = user?.name ?? 'Unknown User';
                                  final userRegion =
                                      user?.region ?? 'Unknown Region';

                                  return UserDiaryTile(
                                    imageUrl: diary.imageUrl,
                                    name: userName,
                                    region: userRegion,
                                    diaryContent: diary.content,
                                    onFollowPressed: () {
                                      print('Follow button pressed');
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
    );
  }
}
