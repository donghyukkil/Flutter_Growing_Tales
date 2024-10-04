import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/widgets/user_info_tile.dart';
import '../../core/widgets/custom_text.dart';

class UserDiaryTile extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String region;
  final String diaryContent;
  final VoidCallback onFollowPressed;

  const UserDiaryTile({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.region,
    required this.diaryContent,
    required this.onFollowPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 20.h,
      ),

      // padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.black,
            width: 2,
          ),
          left: BorderSide(
            color: Colors.black,
            width: 2,
          ),
          right: BorderSide(
            color: Colors.black,
            width: 2,
          ),
          bottom: BorderSide(
            color: Colors.black,
            width: 7,
          ),
        ),
        borderRadius: BorderRadius.circular(10.r),
      ),
      //todo Container에 height 속성 대신 Expaneded?
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          UserInfoTile(
            imageUrl: imageUrl,
            name: name,
            region: region,
            buttonText: 'Follow',
            onButtonPressed: onFollowPressed,
            showBorder: false,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                CustomText(
                  text: diaryContent,
                  maxLines: 1,
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Flexible(
                      flex: 2,
                      child: Row(
                        children: [
                          Icon(
                            Icons.chat_bubble_outline,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text('324'),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Flexible(
                      flex: 5,
                      child: Row(
                        children: [
                          Icon(
                            Icons.favorite_border,
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Text('3.2k'),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                            alignment: Alignment.center,
                            child: Icon(Icons.ios_share)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
