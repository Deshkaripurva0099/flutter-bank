import 'package:flutter/material.dart';

class UpdateKYC33Style {
  // Background gradient
  static const BoxDecoration backgroundGradient = BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xFF900603), Color(0xFF0f172a), Color(0xFF900603)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );

  // Card container decoration
  static final BoxDecoration cardDecoration = BoxDecoration(
    gradient: const LinearGradient(
      colors: [Color(0xFF900603), Color(0xFF0f172a), Color(0xFF900603)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(24),
    border: Border.all(color: Colors.white.withOpacity(0.2)),
    boxShadow: const [
      BoxShadow(color: Colors.black54, blurRadius: 20, offset: Offset(0, 10)),
    ],
  );

  static const EdgeInsets cardPadding = EdgeInsets.all(32);

  // Title text style
  static const TextStyle titleStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // Video container decoration
  static final BoxDecoration videoBoxDecoration = BoxDecoration(
    color: Colors.white.withOpacity(0.05),
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: Colors.white.withOpacity(0.2)),
  );

  // Common primary button style
  static final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF900603),
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  );
}
