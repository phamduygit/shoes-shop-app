import 'package:flutter/material.dart';
import 'package:shoes_shop_app/constant/colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(),
    primarySwatch: Colors.blue,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: AppColors.secondaryColor,
    ),
    // textSelectionTheme: const TextSelectionThemeData(
    //   cursorColor: AppColors.secondaryTextColor,
    //   selectionColor: AppColors.secondaryTextColor,
    //   selectionHandleColor: AppColors.secondaryTextColor,
    // ),
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    colorScheme: const ColorScheme.dark(),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
    ),
  );
}
