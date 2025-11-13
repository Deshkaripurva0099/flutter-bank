import 'package:flutter/material.dart';

class CustomerIDStyle {
  /* ===================== Container ===================== */
  static const LinearGradient containerGradient = LinearGradient(
    colors: [Color(0xFF900603), Color(0xFF0f172a), Color(0xFF900603)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const EdgeInsets containerPadding = EdgeInsets.all(6);
  static const TextStyle defaultFont = TextStyle(
    fontFamily: 'Segoe UI',
    color: Colors.white,
  );

  /* ===================== Card ===================== */
  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF900603), Color(0xFF0f172a), Color(0xFF900603)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static BoxDecoration cardDecoration = BoxDecoration(
    gradient: cardGradient,
    borderRadius: BorderRadius.circular(24),
    border: Border.all(color: Colors.white24, width: 1),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.5),
        offset: const Offset(0, 20),
        blurRadius: 50,
      ),
    ],
  );

  static const EdgeInsets cardPadding = EdgeInsets.symmetric(
    horizontal: 32,
    vertical: 20,
  );

  /* ===================== Logo ===================== */
  static BoxDecoration logoDecoration = BoxDecoration(
    color: Color(0xFF900603),
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.6),
        offset: const Offset(0, 8),
        blurRadius: 25,
      ),
    ],
  );

  static const TextStyle logoIcon = TextStyle(
    color: Colors.white,
    fontSize: 28,
  );

  /* ===================== Titles ===================== */
  static const TextStyle welcomeTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    height: 1.3,
  );

  static const TextStyle welcomeSubtitle = TextStyle(
    fontSize: 14,
    color: Color(0xFFFFE6E6),
  );

  /* ===================== Customer ID Box ===================== */
  static BoxDecoration customerIdBoxDecoration = BoxDecoration(
    color: Colors.white.withOpacity(0.05),
    border: Border.all(color: Colors.white24),
    borderRadius: BorderRadius.circular(14),
    boxShadow: const [
      BoxShadow(
        color: Color.fromRGBO(255, 255, 255, 0.1),
        blurRadius: 15,
        offset: Offset(0, 0),
      ),
    ],
  );

  static const TextStyle customerIdLabel = TextStyle(
    fontSize: 14,
    color: Color(0xFFFFB3B3),
  );

  static const TextStyle generatedId = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    letterSpacing: 1,
  );

  /* ===================== Info Text ===================== */
  static const TextStyle idInfo = TextStyle(
    fontSize: 14,
    color: Color(0xFFFFE6E6),
  );

  /* ===================== Button ===================== */
  static BoxDecoration buttonDecoration = BoxDecoration(
    color: Color(0xFF721B19),
    borderRadius: BorderRadius.circular(14),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.4),
        blurRadius: 10,
        offset: const Offset(0, 3),
      ),
    ],
  );

  static const TextStyle buttonText = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );

  static const TextStyle arrowIcon = TextStyle(
    color: Colors.white,
    fontSize: 18,
  );

  static BoxDecoration buttonHoverDecoration = BoxDecoration(
    color: Color(0xFF900603),
    borderRadius: BorderRadius.circular(14),
  );

  /* ===================== Footer ===================== */
  static const TextStyle footerText = TextStyle(
    color: Color(0xFFFFCCCC),
    fontSize: 12,
    height: 1.4,
  );

  /* ===================== Animations (CSS mimic) ===================== */
  // NOTE: CSS animations like fadeInBackground, bounceIn, glowPulse
  // can be implemented in Flutter using AnimatedOpacity,
  // AnimatedContainer, or AnimationController if needed.

  static const Duration fadeInDuration = Duration(milliseconds: 1500);
  static const Duration fadeInCardDuration = Duration(milliseconds: 1200);
  static const Duration glowPulseDuration = Duration(milliseconds: 2000);
}
