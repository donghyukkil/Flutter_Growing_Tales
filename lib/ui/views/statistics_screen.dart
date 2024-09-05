import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../core/widgets/user_info_tile.dart';
import '../../core/theme/custom_theme_extension.dart';
import '../../data/dummy_data.dart';
import '../../ui/view_models/users_view_model.dart';

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
              // withinRangeTextStyle: Theme.of(context).textTheme.bodySmall!,
              // rangeEndTextStyle: Theme.of(context).textTheme.bodySmall!,
              // defaultTextStyle: Theme.of(context).textTheme.bodySmall!,
              todayTextStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
              todayDecoration: BoxDecoration(
                color: Color(
                  0xFFFFBD11,
                ),
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
            child: Scrollbar(
              thumbVisibility: true,
              child: ListView.builder(
                itemCount: dummyDiary.length,
                itemBuilder: (context, index) {
                  final diary = dummyDiary[index];

                  return UserInfoTile(
                    imageUrl: diary['image']!,
                    name: diary['title']!,
                    region: 'read me more...',
                    buttonText: 'View',
                    onButtonPressed: () {
                      print(
                        'Viewing ${diary['title']}',
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
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
                'Login',
              ),
            )
          ],
        );
      });
}
