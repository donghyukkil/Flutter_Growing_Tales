import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/dummy_data.dart';

class BookListSection extends StatelessWidget {
  final bool showOnlyTop;

  BookListSection({super.key, required this.showOnlyTop});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> dataToShow =
        showOnlyTop ? [dummyBooks.first] : dummyBooks;

    //todo 북리스트 Divider 구현, 책 타일 사이즈 설정, 커스텀 체크 박스, 커스텀 버튼(delete, save), 책 드롭 다운 버튼
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true, // 부모의 크기에 맞게 축소
          physics: NeverScrollableScrollPhysics(), // 부모 스크롤에 영향을 받음
          itemCount: dataToShow.length,
          itemBuilder: (context, index) {
            final item = dataToShow[index];

            return Column(
              children: [
                SizedBox(height: 20.h),
                Row(
                  children: [
                    SizedBox(
                      width: 130.w,
                      child: Image.asset(item['image']!),
                    ),
                    SizedBox(width: 20.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('By ${item['username']}'),
                        Text(item['title']!),
                      ],
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
