import 'package:flutter/material.dart';
import 'package:flutter_issue_tracker/constants/colors.dart';

enum AppTheme {
  light,
  dark,
}

class AppThemeData {
  // Dark theme data
  static final ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(
      // background: AppColors.darkSurface,
      // onBackground: AppColors.white,
      // surface: AppColors.darkSurface,
      // onSurface: AppColors.white,
      primary: AppColors.darkBlue,
      onPrimary: AppColors.white,
      secondary: AppColors.white,
      onSecondary: AppColors.black,
    ),
  );

  // Light theme data
  static final ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(
      // background: AppColors.white,
      onBackground: AppColors.black,
      // surface: AppColors.white,
      onSurface: AppColors.black,
      primary: AppColors.white,
      onPrimary: AppColors.black,
      secondary: AppColors.black,
      onSecondary: AppColors.white,
    ),
  );
}
