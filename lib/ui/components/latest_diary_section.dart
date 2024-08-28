import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:growing_tale/core/data/dummy_data.dart';

import '../../core/constants/app_constants.dart';

class LatestDiarySection extends StatelessWidget {
  const LatestDiarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20.h,
        ),
        Text(
          'Latest Diary',
          style: AppConstants.bodyStyle,
        ),
        SizedBox(
          height: 110.h,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: dummyDiary.length,
              itemBuilder: (context, index) {
                final item = dummyDiary[index];

                return Container(
                  width: 120.w,
                  margin: EdgeInsets.fromLTRB(0, 0, 10.w, 0),
                  decoration: (BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        item['image']!,
                      ),
                    ),
                  )),
                );
              }),
        )
      ],
    );
  }
}
