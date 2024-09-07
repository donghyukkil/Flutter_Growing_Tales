import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../core/widgets/user_info_tile.dart';
import '../../core/theme/custom_theme_extension.dart';
import '../../core/utils/dialog_utils.dart';
import '../../core/constants/app_colors.dart';

import '../../ui/view_models/users_view_model.dart';
import '../../ui/view_models/diary_view_model.dart';
import '../../ui/views/landing_screen.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Theme.of(context).paddingHorizontal20Vertical10,
      child: Column(
        children: [
          Consumer<UsersViewModel>(
            builder: (context, userViewModel, child) {
              final user = userViewModel.state.user;

              return UserInfoTile(
                imageUrl: user?.imageUrl ?? 'assets/dummy1.png',
                name: user?.name ?? 'Login plz',
                region: user?.region ?? 'Find your loves',
                buttonText: user == null ? 'Login' : 'Logout',
                onButtonPressed: () {
                  if (user == null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LandingPage(),
                      ),
                    );
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
          //todo 사용자 찾기 아이콘 구현하기
          TableCalendar(
            focusedDay: DateTime.now(),
            firstDay: DateTime.now().subtract(
              Duration(
                days: 30,
              ),
            ),
            lastDay: DateTime.now().add(
              Duration(
                days: 30,
              ),
            ),
            calendarStyle: CalendarStyle(
              todayTextStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
              todayDecoration: BoxDecoration(
                color: AppColors.followButtonColor,
                shape: BoxShape.circle,
              ),
              selectedTextStyle:
                  Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
              selectedDecoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              cellMargin: EdgeInsets.all(
                4.w,
              ),
            ),
            headerStyle: HeaderStyle(
              titleTextStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
              formatButtonVisible: false,
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 15.sp,
                  ),
              weekendStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 15.sp,
                    color: Colors.red,
                  ),
            ),
          ),
          SizedBox(
            height: 25.h,
          ),
          Expanded(
            child: Consumer<DiaryViewModel>(
              builder: (context, diaryViewModel, child) {
                final userId =
                    context.read<UsersViewModel>().currentUser?.id ?? '';

                if (userId.isNotEmpty &&
                    diaryViewModel.state.userDiaries.isEmpty) {
                  // issue: notifiyListener() method was called during the build phase of the widget tree.
                  // In Flutter updates to the UI should be done outside the bulild pross to avoid confilcts with ongoing rendering cycle
                  // -> solution: Delay the state change until after build.
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    diaryViewModel.fetchDiariesByUserId(
                        userId); // to delay state changes unitl after the current frame is build;
                  });
                }

                final diaries = diaryViewModel.state.userDiaries;

                //todo 계속 네트워크 요청됨.
                // print(diaries);

                if (diaries.isEmpty) {
                  return Center(
                    child: Text('No Diareis Found'),
                  );
                }

                return Scrollbar(
                  thumbVisibility: true,
                  child: ListView.builder(
                    itemCount: diaries.length,
                    itemBuilder: (context, index) {
                      final diary = diaries[index];

                      return UserInfoTile(
                        imageUrl: diary.imageUrl,
                        name: diary.title,
                        region: diary.content,
                        buttonText: 'View',
                        onButtonPressed: () {},
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
