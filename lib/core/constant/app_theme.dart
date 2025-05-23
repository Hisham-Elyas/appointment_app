import 'package:flutter/material.dart';

import 'app_color.dart';

class AppTheme {
  static ThemeData lightEnglish = ThemeData(
      // fontFamily: '',
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColor.backgroundColor,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        color: AppColor.backgroundColor,
      ),
      textTheme: const TextTheme(
        // titleLarge: TextStyle(color: AppColor.fontColor1),
        // titleMedium: TextStyle(color: AppColor.fontColor2),
        // titleSmall: TextStyle(color: AppColor.fontColor3),

        // ////
        // bodyLarge: TextStyle(color: AppColor.fontColor1),
        // bodyMedium: TextStyle(color: AppColor.fontColor2),
        // bodySmall: TextStyle(color: AppColor.fontColor3),

        ////
        displayLarge: TextStyle(color: AppColor.fontColor1),
        displayMedium: TextStyle(color: AppColor.fontColor2),
        displaySmall: TextStyle(color: AppColor.fontColor3),
      ),
      colorScheme: const ColorScheme.light(
        brightness: Brightness.light,
        // seedColor: AppColor.mainColor,
        primary: AppColor.mainColor,
        secondary: AppColor.mainColor2,
        onPrimary: AppColor.mainColor3,
        surface: AppColor.backgroundColor,
        onSurface: AppColor.backgroundColor2,
      ));
  static ThemeData darkEnglish = ThemeData(
      // fontFamily: '',
      brightness: Brightness.dark,
      primaryColorDark: AppColor.mainColor,
      textTheme: const TextTheme(
          displayLarge: TextStyle(color: AppColor.backgroundColor),
          displayMedium: TextStyle(color: AppColor.fontColor1)),
      useMaterial3: true,
      colorScheme: ColorScheme.dark(
        brightness: Brightness.dark,
        // seedColor: AppColor.mainColor,
        primary: AppColor.mainColor,
        secondary: AppColor.mainColor2.withAlpha(200),
        onPrimary: AppColor.mainColor3,
        // background: AppColor.backgroundColor,
        onSurface: AppColor.backgroundColor2.withAlpha(200),
      ));

  static ThemeData lightArabic = ThemeData(
      brightness: Brightness.light,
      fontFamily: 'Cairo',
      useMaterial3: true,
      scaffoldBackgroundColor: AppColor.backgroundColor,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        color: AppColor.backgroundColor,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: AppColor.fontColor1),
        displayMedium: TextStyle(color: AppColor.fontColor2),
        displaySmall: TextStyle(color: AppColor.fontColor3),
      ),
      colorScheme: const ColorScheme.light(
        brightness: Brightness.light,
        // seedColor: AppColor.mainColor,
        primary: AppColor.mainColor,
        secondary: AppColor.mainColor2,
        onPrimary: AppColor.mainColor3,
        surface: AppColor.backgroundColor,
        onSurface: AppColor.backgroundColor2,
      ));
  static ThemeData darkArabic = ThemeData(
      brightness: Brightness.dark,
      fontFamily: 'Cairo',
      primaryColorDark: AppColor.mainColor,
      textTheme: const TextTheme(
          displayLarge: TextStyle(color: AppColor.backgroundColor),
          displayMedium: TextStyle(color: AppColor.fontColor1)),
      useMaterial3: true,
      colorScheme: ColorScheme.dark(
        brightness: Brightness.dark,
        primary: AppColor.mainColor,
        secondary: AppColor.mainColor2.withAlpha(200),
        onPrimary: AppColor.mainColor3,
        onSurface: AppColor.backgroundColor2.withAlpha(200),
      ));
}
