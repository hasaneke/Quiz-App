import 'package:ehliyetim/core/constants/colors.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static final purpleTheme = ThemeData.light().copyWith(
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(textStyle: const TextStyle(color: AppColors.iconColor)),
      ),
      appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.appBarColor, foregroundColor: AppColors.appBarForegroundColor, elevation: 0),
      scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
      iconTheme: const IconThemeData(color: AppColors.iconColor));
}
