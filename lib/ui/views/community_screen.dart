import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/custom_theme_extension.dart';
import '../../core/widgets/user_info_tile.dart';
import '../../data/dummy_data.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  //todo 섹션화.
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Theme.of(context).paddingHorizontal20Vertical10,
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                UserInfoTile(
                  imageUrl: dummyUsers[0].imageUrl,
                  name: 'donghyuk',
                  region: 'Seoul',
                  buttonText: 'Login',
                  onButtonPressed: () {},
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
                          height: 220.h,
                          child: Column(
                            children: [
                              UserInfoTile(
                                imageUrl: item.imageUrl,
                                name: item.name,
                                region: item.region,
                                buttonText: 'Follow',
                                onButtonPressed: () {
                                  print(
                                    'test',
                                  );
                                },
                                showBorder: false,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.w,
                                ),
                                child: Text(
                                  style: Theme.of(context).textTheme.bodySmall,
                                  'Work with us and forget about others Work with us and forget about others Work with us and forget about others Work with us and forget about others ',
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
                                          Text(
                                            '324',
                                          ),
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
}
