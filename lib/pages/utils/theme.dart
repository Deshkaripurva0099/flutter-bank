import 'package:flutter/material.dart';
import 'constants.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppConstants.primaryRed,
    scaffoldBackgroundColor: AppConstants.lightGrey,
    
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppConstants.primaryRed,
      primary: AppConstants.primaryRed,
      secondary: AppConstants.secondaryGold,
    ),
    
    appBarTheme: const AppBarTheme(
      backgroundColor: AppConstants.primaryRed,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    
    // cardTheme: CardTheme(
    //   elevation: 2,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
    //   ),
    //   color: Colors.white,
    //   margin: const EdgeInsets.symmetric(
    //     horizontal: AppConstants.defaultPadding,
    //     vertical: AppConstants.smallPadding,
    //   ),
    // ),
    
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppConstants.primaryRed,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.smallRadius),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppConstants.primaryRed,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 14,
        ),
        side: const BorderSide(
          color: AppConstants.primaryRed,
          width: 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.smallRadius),
        ),
      ),
    ),
    
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.smallRadius),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.smallRadius),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.smallRadius),
        borderSide: const BorderSide(
          color: AppConstants.primaryRed,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.smallRadius),
        borderSide: const BorderSide(color: AppConstants.dangerRed),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      filled: true,
      fillColor: Colors.white,
    ),
  );
}