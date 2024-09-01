import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        titleTextStyle: GoogleFonts.nerkoOne(
          fontSize: 30.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      textTheme: TextTheme(
        headlineLarge: GoogleFonts.nerkoOne(
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        headlineSmall: GoogleFonts.nerkoOne(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        bodyLarge: GoogleFonts.nerkoOne(
          fontSize: 35.sp,
          fontWeight: FontWeight.normal,
          color: Colors.black,
        ),
        bodyMedium: GoogleFonts.nerkoOne(
          fontSize: 20.sp,
          fontWeight: FontWeight.normal,
          color: Colors.black,
        ),
        bodySmall: GoogleFonts.nerkoOne(
          fontSize: 13.sp,
          fontWeight: FontWeight.normal,
          color: Colors.black,
        ),
      ),
    );
  }
}
