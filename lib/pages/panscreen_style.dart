import 'package:flutter/material.dart';

class PANScreenStyle {
  /* ===================== Container ===================== */
  static const LinearGradient containerGradient = LinearGradient(
    colors: [Color(0xFF900603), Color(0xFF0f172a), Color(0xFF900603)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const TextStyle containerTextStyle = TextStyle(fontFamily: 'Segoe UI');

  /* ===================== Back Button ===================== */
  static const TextStyle backButtonTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 16,
  );

  static const TextStyle backArrowStyle = TextStyle(
    fontSize: 18,
    color: Colors.white,
  );

  static const Color backButtonHoverColor = Color(0xFFFFB3B3);

  /* ===================== Card ===================== */
  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF900603), Color(0xFF0f172a), Color(0xFF900603)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static BoxDecoration cardBoxDecoration = BoxDecoration(
    gradient: cardGradient,
    borderRadius: BorderRadius.circular(24),
    border: Border.all(color: Colors.white24, width: 1),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.5),
        blurRadius: 50,
        offset: Offset(0, 20),
      ),
    ],
  );

  /* ===================== Icon ===================== */
  static const TextStyle iconStyle = TextStyle(
    fontSize: 48,
    color: Colors.white,
  );

  /* ===================== Header ===================== */
  static const TextStyle titleStyle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 16,
    color: Color(0xFFFFE6E6),
  );

  /* ===================== Form ===================== */
  static const TextStyle labelStyle = TextStyle(
    color: Color(0xFFFFE6E6),
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static final InputDecoration inputDecoration = InputDecoration(
    filled: true,
    fillColor: Colors.white10.withOpacity(0.05),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.white10),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFFFF9999)),
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
  );

  static const TextStyle inputTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 18,
    letterSpacing: 2,
  );

  static const TextStyle formatNoteStyle = TextStyle(
    color: Color(0xFFFFCCCC),
    fontSize: 12,
    textBaseline: TextBaseline.alphabetic,
  );

  /* ===================== Info Box ===================== */
  static final BoxDecoration infoBoxDecoration = BoxDecoration(
    color: Colors.white10.withOpacity(0.05),
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: Colors.white10.withOpacity(0.1)),
  );

  static const TextStyle infoTextStyle = TextStyle(
    color: Color(0xFFFFE6E6),
    fontSize: 14,
  );

  /* ===================== Verify Button ===================== */
  static final ButtonStyle verifyButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Color(0xFF900603),
    padding: const EdgeInsets.all(16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  );

  static const TextStyle verifyButtonTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );

  static const TextStyle arrowIconStyle = TextStyle(
    fontSize: 18,
    color: Colors.white,
  );
}
