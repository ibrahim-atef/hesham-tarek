import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: Color(0xFFF2B91D), // Medium Purple
    secondary: Color(0xFF2C4649), // Medium Purple
    tertiary: Color(0xff1D3AF2),
    outline: Color(0xFF212121),
    surface: Color(0xFFFAFAFA), // Very light gray
    onPrimary: Color(0xFFFFFFFF), // Text color on primary
    onSecondary: Color(0xFFFFFFFF), // Text color on secondary
    onSurface: Color(0xFF4F6163), // Text color on surface
  ),
  scaffoldBackgroundColor: const Color(0xFFFAFAFA),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xffF2B91D),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
  ),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
    filled: true,
    fillColor: Colors.white,
    alignLabelWithHint: true,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    border: OutlineInputBorder(
        borderSide: BorderSide.none, borderRadius: BorderRadius.circular(8)),
  ),
  appBarTheme: AppBarTheme(
    centerTitle: true,
    backgroundColor: const Color(0xFF2C4649),
    titleTextStyle: TextStyle(
        color: const Color(0xFFF2B91D),
        fontSize: 22.sp,
        fontWeight: FontWeight.w600),
  ),
);
