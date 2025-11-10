import 'package:flutter/material.dart';

/// ✅ Equivalent of your FixedDepositForm.css file in Flutter style format.
/// All colors, paddings, and effects are preserved as closely as possible.

class FdFormStyles {
  // Background color for the entire page
  static const Color backgroundColor = Color(0xFFF8F9FA);

  // 🔹 Container Style (.fd-container15)
  static BoxDecoration get containerBox => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(14),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.08),
        blurRadius: 18,
        offset: const Offset(0, 8),
      ),
    ],
  );

  static const EdgeInsets containerPadding = EdgeInsets.symmetric(
    vertical: 4,
    horizontal: 30,
  );

  // 🔹 Title (.fd-title)
  static const TextStyle titleText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const Border titleBottomBorder = Border(
    bottom: BorderSide(color: Color(0x20900603), width: 2),
  );

  // 🔹 Summary (.fd-summary-alert)
  static BoxDecoration get summaryBox => BoxDecoration(
    gradient: const LinearGradient(
      colors: [Color(0xFF900603), Color(0xFFB71C1C)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(12),
  );

  static const TextStyle summaryText = TextStyle(
    color: Colors.white,
    fontSize: 16,
    height: 1.5,
  );

  // 🔹 Card Wrapper (.fd-card15)
  static BoxDecoration get cardBox => BoxDecoration(
    color: const Color(0xFFFFF8F8),
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 12,
        offset: const Offset(0, 2),
      ),
    ],
  );

  // 🔹 Form Label
  static const TextStyle labelText = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  // 🔹 Input Decoration (for input fields)
  static InputDecoration inputDecoration(String hint) => InputDecoration(
    hintText: hint,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Color(0xFFCCCCCC)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Color(0xFF900603)),
    ),
  );

  // 🔹 Dropdown Decoration (same as input)
  static InputDecoration get dropdownDecoration => InputDecoration(
    contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF900603)),
    ),
  );

  // 🔹 Maturity Summary Card (.fd-maturity-card)
  static BoxDecoration get maturityBox => BoxDecoration(
    gradient: const LinearGradient(
      colors: [Color(0xFFF5F7FA), Color(0xFFD7D7D8), Color(0xFFF5F7FA)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 4,
        offset: const Offset(0, 1),
      ),
      BoxShadow(
        color: Colors.grey.withOpacity(0.15),
        blurRadius: 6,
        offset: const Offset(0, 1),
      ),
    ],
  );

  static const TextStyle maturityText = TextStyle(
    color: Color(0xFF2C3E50),
    fontSize: 16,
  );

  static const TextStyle maturityTitle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  // 🔹 Buttons (.btn-primary55 and .btn-outline56)
  static ButtonStyle get primaryButton => ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF900603),
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 22),
    textStyle: const TextStyle(fontWeight: FontWeight.bold),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  );

  static ButtonStyle get outlineButton => OutlinedButton.styleFrom(
    side: const BorderSide(color: Color(0xFF900603), width: 2),
    foregroundColor: const Color(0xFF900603),
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 22),
    textStyle: const TextStyle(fontWeight: FontWeight.bold),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  );

  // 🔹 Responsive title (optional)
  static TextStyle responsiveTitle(double width) => TextStyle(
    fontSize: width < 768 ? 22 : 28,
    fontWeight: FontWeight.bold,
    color: const Color(0xFF900603),
  );

  // 🔹 App Bar Color
  static const Color appBarColor = Color(0xFF900603);

  // 🔹 Page Padding
  static const EdgeInsets pagePadding = EdgeInsets.all(16);

  // 🔹 Summary Padding and Margin
  static const EdgeInsets summaryPadding = EdgeInsets.all(16);
  static const EdgeInsets summaryMargin = EdgeInsets.only(bottom: 16);

  // 🔹 Maturity Padding
  static const EdgeInsets maturityPadding = EdgeInsets.all(16);

  // 🔹 Hint Text Style
  static const TextStyle hintText = TextStyle(
    color: Color(0xFF888888),
    fontSize: 14,
  );
}
