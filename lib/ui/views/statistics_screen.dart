import 'package:flutter/material.dart';
import 'package:growing_tales/core/theme/custom_theme_extension.dart';
import 'package:growing_tales/data/dummy_data.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../core/widgets/user_info_tile.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Theme.of(context).paddingHorizontal20Vertical10,
      child: Column(
        children: [
          UserInfoTile(
            imageUrl: 'assets/dummy1.png',
            name: 'Login plz',
            region: 'Find your loves',
            buttonText: 'Login',
            onButtonPressed: () {
              print(
                'Login',
              );
            },
          ),
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
              withinRangeTextStyle: Theme.of(context).textTheme.bodySmall!,
              rangeEndTextStyle: Theme.of(context).textTheme.bodySmall!,
              defaultTextStyle: Theme.of(context).textTheme.bodySmall!,
              weekendTextStyle: Theme.of(context).textTheme.bodySmall!,
              weekNumberTextStyle: Theme.of(context).textTheme.bodySmall!,
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
                4.0,
              ),
            ),
            headerStyle: HeaderStyle(
              titleTextStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
              formatButtonVisible: false,
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 15,
                  ),
              weekendStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 15,
                    color: Colors.red,
                  ),
            ),
          ),
          SizedBox(
            height: 25,
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
