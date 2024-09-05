import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../core/theme/custom_theme_extension.dart';
import '../../core/widgets/user_info_tile.dart';
import '../../data/dummy_data.dart';
import '../../ui/view_models/users_view_model.dart';
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
                          _showLoginDialog(context);
                        } else {
                          userViewModel.logout();
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
                  child: Scrollbar(
                    child: ListView.builder(
                      itemCount: dummyUsers.length,
                      itemBuilder: (context, index) {
                        final item = dummyUsers[index];

                        return UserDiaryTile(
                          imageUrl: item.imageUrl,
                          name: item.name,
                          region: item.region,
                          diaryContent:
                              'Work with us and forget about others Work with us and forget about others Work with us and forget about others Work with us and forget about others',
                          onFollowPressed: () {
                            print('Follow button pressed');
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login Required'),
          content: Text('Please log in to continue'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                final userViewModel = context.read<UsersViewModel>();
                await userViewModel.loginWithGoogle();

                if (userViewModel.currentUser != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Logged in successfully')),
                  );
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Login failed')));
                }
              },
              child: Text(
                'Cancel',
              ),
            )
          ],
        );
      },
    );
  }
}
