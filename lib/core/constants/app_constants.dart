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

  static final googleStyle = GoogleFonts.roboto(
    textStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
  );
  static final koreanStyleBodySmall = GoogleFonts.jua(
    textStyle: TextStyle(
        color: Colors.black, fontWeight: FontWeight.w100, fontSize: 13.sp),
  );

  static List<String> bannedKeywords = [
    'porn',
    'sex',
    'nude',
    'xxx',
    'adult',
    'erotic',
    'fetish',
    'bdsm',
    'hardcore',
    'hentai',
    'incest',
    'naked',
    'escort',
    'prostitute',
    'strip',
    'taboo',
    'explicit',
    'voyeur',
    'camgirl',
    'cam',
    'pornstar',
    'kink',
    '야동',
    '성인',
    '섹스',
    '포르노',
    '에로',
    '누드',
    '노출',
    '성매매',
    '성폭행',
    '음란',
    '야설',
    '몸매',
    '자위',
    '불륜',
    '외설',
    '변태',
    '강간',
    '스와핑',
    '애널',
    '성도착',
    '성희롱',
    '섹스토이',
    '사창가',
  ];
}
