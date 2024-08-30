import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/dummy_data.dart';

class TagSection extends StatelessWidget {
  const TagSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10.h,
        ),
        Text(
          'Tags',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        SizedBox(
          height: 10.h,
        ),
        SizedBox(
          width: double.infinity,
          height: 90.h,
          child: Scrollbar(
            thumbVisibility: true,
            child: SingleChildScrollView(
              child: Wrap(
                alignment: WrapAlignment.start,
                spacing: 8.w,
                runSpacing: 4.h,
                children: dummyTags.map(
                  (item) {
                    return Chip(
                      backgroundColor: item['color'],
                      label: Text(
                        item['tag'],
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
