import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/widgets/user_info_tile.dart';

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
        bottom: 50.h,
      ),
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
      height: 220.h,
      child: Column(
        children: [
          UserInfoTile(
            imageUrl: imageUrl,
            name: name,
            region: region,
            buttonText: 'Follow',
            onButtonPressed: onFollowPressed,
            showBorder: false,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            child: Text(
              diaryContent,
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
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
                  width: 20,
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Icon(
                        Icons.favorite_border,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text('3.2k'),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Icon(Icons.ios_share),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
