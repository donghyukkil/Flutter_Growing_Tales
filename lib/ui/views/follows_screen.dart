import 'package:flutter/material.dart';

import '../../data/dummy_data.dart';
import '../../core/widgets/user_info_tile.dart';
import '../../core/widgets/custom_bottom_navigation_bar.dart';
import '../../core/theme/custom_theme_extension.dart';

class FollowsScreen extends StatelessWidget {
  const FollowsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Follows'),
      ),
      body: Padding(
        padding: Theme.of(context).paddingHorizontal20Vertical10,
        child: Column(
          children: [
            Expanded(
              child: Scrollbar(
                thumbVisibility: true,
                child: ListView.builder(
                  itemCount: dummyUsers.length,
                  itemBuilder: (context, index) {
                    final item = dummyUsers[index];

                    return UserInfoTile(
                      imageUrl: item.imageUrl,
                      name: item.name,
                      region: item.region,
                      onButtonPressed: () {
                        print(
                          'Follow',
                        );
                      },
                      buttonText: 'Follow',
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
