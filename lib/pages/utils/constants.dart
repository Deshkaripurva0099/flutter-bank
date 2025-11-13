import 'package:flutter/material.dart';

class AppConstants {
  // Colors
  static const Color primaryRed = Color(0xFF900603);
  static const Color secondaryGold = Color(0xFFffc107);
  static const Color successGreen = Color(0xFF28a745);
  static const Color dangerRed = Color(0xFFdc3545);
  static const Color warningYellow = Color(0xFFffc107);
  static const Color infoBlue = Color(0xFF17a2b8);
  static const Color lightGrey = Color(0xFFF5F5F5);
  
  // Text Styles
  static const TextStyle headingStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );
  
  static const TextStyle subHeadingStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.black54,
  );
  
  static const TextStyle bodyStyle = TextStyle(
    fontSize: 14,
    color: Colors.black87,
  );
  
  // Padding & Margins
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  
  // Border Radius
  static const double defaultRadius = 12.0;
  static const double smallRadius = 8.0;
  
  // Currency Symbol
  static const String rupeeSymbol = '₹';
}