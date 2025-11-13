import 'package:flutter/material.dart';

class AadharScreenStyle {
  /* ===================== Container ===================== */
  static const LinearGradient containerGradient = LinearGradient(
    colors: [Color(0xFF900603), Color(0xFF0f172a), Color(0xFF900603)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const EdgeInsets containerPadding = EdgeInsets.all(6);

  static const TextStyle containerFont = TextStyle(fontFamily: 'Segoe UI');

  /* ===================== Back Button ===================== */
  static const TextStyle backButtonText = TextStyle(
    color: Colors.white,
    fontSize: 16,
  );

  static const TextStyle backButtonArrow = TextStyle(
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

  static BoxDecoration cardDecoration = BoxDecoration(
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

  static const EdgeInsets cardPadding = EdgeInsets.symmetric(
    vertical: 30,
    horizontal: 32,
  );

  static const double cardMaxWidth = 400;

  static const TextStyle cardTextColor = TextStyle(color: Colors.white);

  /* ===================== Icon ===================== */
  static const double iconFontSize = 48;
  static const EdgeInsets iconContainerMargin = EdgeInsets.only(bottom: 2);

  /* ===================== Header ===================== */
  static const EdgeInsets headerMargin = EdgeInsets.only(bottom: 32);
  static const TextStyle headerTitle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static const TextStyle headerSubtitle = TextStyle(
    fontSize: 16,
    color: Color(0xFFFFE6E6),
  );

  /* ===================== Form ===================== */
  static const double formGap = 30;

  static const TextStyle label = TextStyle(
    color: Color(0xFFFFE6E6),
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static InputDecoration inputDecoration = InputDecoration(
    filled: true,
    fillColor: Colors.white10,
    hintStyle: const TextStyle(
      fontSize: 16,
      letterSpacing: 0,
      color: Colors.white54,
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.white10, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFFF9999), width: 2),
    ),
  );

  static const TextStyle inputText = TextStyle(
    fontSize: 24,
    letterSpacing: 4,
    color: Colors.white,
    textBaseline: TextBaseline.alphabetic,
  );

  /* ===================== Info Box ===================== */
  static BoxDecoration infoBoxDecoration = BoxDecoration(
    color: Colors.white10,
    border: Border.all(color: Colors.white10, width: 1),
    borderRadius: BorderRadius.circular(12),
  );

  static const TextStyle infoText = TextStyle(
    color: Color(0xFFFFE6E6),
    fontSize: 14,
    height: 1.4,
  );

  static const TextStyle infoIcon = TextStyle(fontSize: 20);

  /* ===================== Buttons ===================== */
  static ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Color(0xFF900603),
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 16),
    minimumSize: const Size(300, 56),
    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    shadowColor: const Color.fromRGBO(255, 0, 0, 0.5),
    elevation: 10,
  );

  static const TextStyle arrowIcon = TextStyle(
    fontSize: 18,
    color: Colors.white,
  );

  static const Color verifyButtonDisabledColor = Colors.white54;

  /* ===================== OTP ===================== */
  static BoxDecoration otpInputDecoration = BoxDecoration(
    color: Colors.white10,
    border: Border.all(color: Colors.white10, width: 1),
    borderRadius: BorderRadius.circular(12),
  );

  static const TextStyle otpInputText = TextStyle(
    color: Colors.white,
    fontSize: 20,
  );

  static BoxDecoration otpInputFocused = BoxDecoration(
    border: Border.all(color: Color(0xFFFF9999), width: 1.5),
    boxShadow: [BoxShadow(color: Color(0x33FF9999), blurRadius: 3)],
    borderRadius: BorderRadius.circular(12),
  );

  /* ===================== Resend OTP ===================== */
  static const TextStyle resendButton = TextStyle(
    color: Color(0xFFFFB3B3),
    fontSize: 14,
  );

  static const Color resendButtonHoverColor = Colors.white;
}
