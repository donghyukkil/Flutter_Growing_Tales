import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppConstants {
  static const Size designSize = Size(375, 812);

  static EdgeInsets paddingHorizontal20wVertical10h() {
    return EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h);
  }

  static const EdgeInsets paddingHorizontal20 =
      EdgeInsets.symmetric(horizontal: 20);
  static const EdgeInsets paddingHorizontal12 =
      EdgeInsets.symmetric(horizontal: 12);
  static const EdgeInsets paddingVertical10 =
      EdgeInsets.symmetric(vertical: 10);
  static const EdgeInsets paddingAll12 = EdgeInsets.all(12);

  static final headingStyle = GoogleFonts.nerkoOne(
    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  );

  static final bodyStyle = GoogleFonts.nerkoOne(
    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  );
}
