import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_constants.dart';
import '../../data/dummy_data.dart';
import '../../core/widgets/custom_circle_avatar.dart';
import '../../core/widgets/custom_follow_button.dart';

class FollowsScreen extends StatelessWidget {
  const FollowsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppConstants.paddingHorizontal20wVertical10h(),
      child: Column(
        children: [
          SizedBox(
            height: 590.h,
            child: Scrollbar(
              thumbVisibility: true,
              child: ListView.builder(
                itemCount: dummyUsers.length,
                itemBuilder: (context, index) {
                  final item = dummyUsers[index];

                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.h,
                    ),
                    child: Container(
                      height: 100.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2.w,
                        ),
                        borderRadius: BorderRadius.circular(
                          10.r,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(
                          10.w,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomCircleAvatar(
                              imageUrl: item.imageUrl,
                              size: 80.r,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  Text(
                                    item.region,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          fontSize: 13.sp,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            CustomFollowButton(
                              text: 'Follow',
                              onPressed: () {
                                print(
                                  'Follow',
                                );
                              },
                              width: 60.w,
                              height: 30.h,
                              backgroundColor: Color(
                                0xFFFFBD11,
                              ),
                              textColor: Colors.black,
                              borderColor: Colors.black,
                              borderRadius: 10.r,
                              borderWidth: 2.w,
                            ),
                          ],
                        ),
                      ),
                    ),
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
