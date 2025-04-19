import 'package:book_hotel/core/util/UtilColors.dart';
import 'package:book_hotel/core/extensions/ExtentionString.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    fontFamily: "Roboto",
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(7.r))),
            foregroundColor: Colors.white,
            backgroundColor: UtilColors.primaryKeyColor)),
    appBarTheme: AppBarTheme(
        backgroundColor: UtilColors.primaryKeyColor,
        centerTitle: true,
        titleTextStyle: TextStyle(
            fontSize: 18.sp, fontWeight: FontWeight.w500, color: Colors.white)),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      hintStyle: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: "#808089".toColor(),
      ),
      labelStyle: TextStyle(fontSize: 12.sp, color: UtilColors.primaryKeyColor),
      prefixIconColor: UtilColors.primaryKeyColor,
      fillColor: UtilColors.colorTextField,
      filled: true,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
        borderSide: const BorderSide(
          color: UtilColors.primaryKeyColor,
          width: 2.0,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
        borderSide: const BorderSide(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
    ),
    textTheme: TextTheme(
      titleSmall: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
      titleMedium: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
      titleLarge: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w500),
      labelSmall: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: UtilColors.primaryKeyColor,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedIconTheme: IconThemeData(
        color: UtilColors.primaryKeyColor,
      ),
      unselectedIconTheme: IconThemeData(
        color: Colors.grey,
      ),
      selectedLabelStyle: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: UtilColors.primaryKeyColor),
      unselectedLabelStyle: TextStyle(
          fontSize: 10, fontWeight: FontWeight.w400, color: Colors.grey),
    ),
  );

  static final ThemeData darkTheme = ThemeData();
}
