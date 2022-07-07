import 'package:flutter/material.dart';
import 'package:flutter_issue_tracker/constants/colors.dart';

/// Contains the dark and light [ThemeData]
class AppThemeData {
  // Dark theme data definition
  static final ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(
      primary: AppColors.darkBlue,
      onPrimary: AppColors.white,
      secondary: AppColors.white,
      onSecondary: AppColors.black,
    ),
  );

  // Light theme data definition
  static final ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(
      onBackground: AppColors.black,
      onSurface: AppColors.black,
      primary: AppColors.white,
      onPrimary: AppColors.black,
      secondary: AppColors.black,
      onSecondary: AppColors.white,
    ),
  );
}
