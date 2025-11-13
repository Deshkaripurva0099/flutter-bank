import 'package:flutter/material.dart';

class SignupScreenStyles {
  // ===================== Container =====================
  static const LinearGradient containerGradient = LinearGradient(
    colors: [Color(0xFF900603), Color(0xFF0F172A), Color(0xFF900603)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.5, 1.0],
  );

  static const EdgeInsets containerPadding = EdgeInsets.all(6.0);

  static const TextStyle baseFont = TextStyle(fontFamily: 'Segoe UI');

  // ===================== Back/Next Buttons =====================
  static const TextStyle backNextButtonText = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static ButtonStyle backNextButtonStyle({Alignment? alignment}) {
    return TextButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.zero,
      textStyle: backNextButtonText,
    );
  }

  static const double backNextButtonTop = 20.0;
  static const double backNextButtonFontSize = 16.0;

  // ===================== Card =====================
  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF900603), Color(0xFF0F172A), Color(0xFF900603)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.5, 1.0],
  );

  static BoxDecoration cardDecoration = BoxDecoration(
    gradient: cardGradient,
    borderRadius: BorderRadius.circular(24),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.5),
        blurRadius: 50,
        offset: Offset(0, 20),
      ),
    ],
    border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
  );

  static const EdgeInsets cardPadding = EdgeInsets.symmetric(
    vertical: 20,
    horizontal: 32,
  );

  static const double cardMaxWidth = 350;

  static const TextStyle cardTextColor = TextStyle(color: Colors.white);

  // ===================== Header =====================
  static const TextStyle title = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 14,
    color: Color(0xFFFFE6E6),
  );

  // ===================== Labels =====================
  static const TextStyle label = TextStyle(
    color: Color(0xFFFFE6E6),
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  // ===================== Inputs =====================
  static InputDecoration inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color.fromRGBO(255, 255, 255, 0.6)),
      filled: true,
      fillColor: const Color.fromRGBO(255, 255, 255, 0.05),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color.fromRGBO(255, 255, 255, 0.1)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color.fromRGBO(255, 255, 255, 0.1)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFFF9999), width: 1.5),
      ),
      contentPadding: const EdgeInsets.all(16),
    );
  }

  static const TextStyle inputText = TextStyle(
    color: Colors.white,
    fontSize: 16,
  );

  // ===================== Continue Button =====================
  static ButtonStyle continueButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF900603),
    foregroundColor: Colors.white,
    elevation: 8,
    padding: const EdgeInsets.symmetric(vertical: 16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    shadowColor: const Color.fromRGBO(145, 5, 5, 0.712),
    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  );

  // ===================== Terms Text =====================
  static const TextStyle termsText = TextStyle(
    fontSize: 12,
    color: Color(0xFFFFB3B3),
  );

  // ===================== Responsive (Approximation) =====================
  /// You can handle smaller screens with MediaQuery checks in your widget.
  static double getResponsivePadding(double width) {
    if (width < 480) {
      return 16;
    } else if (width < 768) {
      return 24;
    } else {
      return 32;
    }
  }

  static double getResponsiveFontSize(double width, double baseSize) {
    if (width < 480) return baseSize - 2;
    if (width < 768) return baseSize - 1;
    return baseSize;
  }
}
