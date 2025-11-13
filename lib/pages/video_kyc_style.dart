import 'package:flutter/material.dart';

class VideoKYCStyle {
  /* ===================== Container ===================== */
  static const LinearGradient containerGradient = LinearGradient(
    colors: [Color(0xFF900603), Color(0xFF0f172a), Color(0xFF900603)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const EdgeInsets containerPadding = EdgeInsets.all(16);

  /* ===================== KYC Card ===================== */
  static final BoxDecoration kycCardDecoration = BoxDecoration(
    gradient: const LinearGradient(
      colors: [Color(0xFF900603), Color(0xFF0f172a), Color(0xFF900603)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(24),
    border: Border.all(color: Colors.white24),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.5),
        blurRadius: 30,
        spreadRadius: 5,
      ),
    ],
  );

  static const EdgeInsets kycCardPadding = EdgeInsets.symmetric(
    vertical: 24,
    horizontal: 16,
  );

  /* ===================== Titles & Text ===================== */
  static const TextStyle kycTitleText = TextStyle(
    color: Colors.white,
    fontSize: 26,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle kycSubtitleText = TextStyle(
    color: Color(0xFFFFE6E6),
    fontSize: 14,
  );

  static const TextStyle backButtonText = TextStyle(
    color: Colors.white,
    fontSize: 16,
  );

  static const TextStyle instructionTitle = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontSize: 14,
  );

  static const TextStyle instructionText = TextStyle(
    color: Colors.white70,
    fontSize: 8,
  );

  static const TextStyle recordingText = TextStyle(
    color: Colors.redAccent,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  /* ===================== Buttons ===================== */
  static final ButtonStyle recordButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF721b19),
    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
  );

  /* ===================== Recording Dot ===================== */
  static final BoxDecoration recordingDotDecoration = BoxDecoration(
    color: Colors.redAccent,
    shape: BoxShape.circle,
    boxShadow: [
      BoxShadow(
        color: Colors.redAccent.withOpacity(0.7),
        blurRadius: 10,
        spreadRadius: 2,
      ),
    ],
  );
}
