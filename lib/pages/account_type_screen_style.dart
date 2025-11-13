import 'package:flutter/material.dart';

class AccountTypeStyle {
  /* ===================== General Colors ===================== */
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [Color(0xFF900603), Color(0xFF0f172a), Color(0xFF900603)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const Color cardColor = Colors.white;
  static const Color accentColor = Colors.greenAccent;
  static const Color borderColor = Colors.white12;
  static const Color lightTextColor = Colors.white70;
  static const Color normalTextColor = Colors.white;
  static const Color borderLight = Colors.white24;

  /* ===================== Page Layout ===================== */
  static const EdgeInsets pagePadding = EdgeInsets.all(16);
  static const EdgeInsets cardPadding = EdgeInsets.all(16);

  /* ===================== Back Button ===================== */
  static const TextStyle backIconStyle = TextStyle(
    fontSize: 18,
    color: normalTextColor,
  );

  static const TextStyle backTextStyle = TextStyle(
    fontSize: 16,
    color: normalTextColor,
  );

  /* ===================== Card Container ===================== */
  static final BoxDecoration cardBoxDecoration = BoxDecoration(
    color: Colors.white.withOpacity(0.05),
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: borderColor),
  );

  /* ===================== Header ===================== */
  static const TextStyle headerTitleStyle = TextStyle(
    color: normalTextColor,
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle headerSubtitleStyle = TextStyle(
    color: lightTextColor,
    fontSize: 14,
  );

  /* ===================== Progress Bar ===================== */
  static final BoxDecoration progressBarDecoration = BoxDecoration(
    color: accentColor,
    borderRadius: BorderRadius.circular(10),
  );

  /* ===================== Account Card ===================== */
  static const EdgeInsets accountCardPadding = EdgeInsets.all(16);

  static final BoxDecoration accountCardDecoration = BoxDecoration(
    color: Colors.white.withOpacity(0.08),
    borderRadius: BorderRadius.circular(14),
    border: Border.all(color: borderLight),
  );

  static const TextStyle accountTitleStyle = TextStyle(
    color: normalTextColor,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle accountDescStyle = TextStyle(
    color: lightTextColor,
    fontSize: 14,
  );

  /* ===================== Features List ===================== */
  static final BoxDecoration dotDecoration = BoxDecoration(
    color: accentColor,
    shape: BoxShape.circle,
  );

  static const TextStyle featureTextStyle = TextStyle(
    color: lightTextColor,
    fontSize: 13,
  );

  /* ===================== Select Row ===================== */
  static const TextStyle selectTextStyle = TextStyle(
    color: normalTextColor,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle selectArrowStyle = TextStyle(
    color: normalTextColor,
    fontSize: 20,
  );

  /* ===================== Footer Note ===================== */
  static const TextStyle footerNoteStyle = TextStyle(
    color: Colors.white54,
    fontSize: 12,
  );
}
