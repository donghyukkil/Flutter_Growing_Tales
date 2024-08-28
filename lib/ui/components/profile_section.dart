import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:growing_tale/core/data/dummy_data.dart';

import '../../core/constants/app_constants.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300.h,
      color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 80.r,
                foregroundColor: Colors.yellow,
                backgroundColor: Colors.yellow,
                child: ClipOval(
                  child: Image(
                    image: AssetImage('assets/profile.png'),
                    width: 200.w,
                    height: 200.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        '276',
                        style: AppConstants.bodyStyle.copyWith(
                          color: Colors.white,
                          fontSize: 30.w,
                        ),
                      ),
                      Text(
                        'image',
                        style: AppConstants.bodyStyle.copyWith(
                          color: Colors.white,
                          fontSize: 20.w,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '62k',
                        style: AppConstants.bodyStyle.copyWith(
                          color: Colors.white,
                          fontSize: 30.w,
                        ),
                      ),
                      Text(
                        'followers',
                        style: AppConstants.bodyStyle.copyWith(
                          color: Colors.white,
                          fontSize: 20.w,
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '23',
                        style: AppConstants.bodyStyle.copyWith(
                          color: Colors.white,
                          fontSize: 30.w,
                        ),
                      ),
                      Text(
                        'following',
                        style: AppConstants.bodyStyle.copyWith(
                          color: Colors.white,
                          fontSize: 20.w,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
