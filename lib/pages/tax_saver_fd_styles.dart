import 'package:flutter/material.dart';

class TaxSaverFDStyles {
  static const fdContainerMaxWidth = 1400.0;

  static const fdHero = BoxDecoration(color: Color(0xFF900603));

  static const fdHeroBackground = BoxDecoration(color: Color(0xFFF8F9FA));

  static const fdHeroPadding = EdgeInsets.symmetric(horizontal: 20);

  static const fdHeroLeftTitle = TextStyle(
    fontSize: 28, // Reduced for mobile
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static const fdHeroLeftParagraph = TextStyle(
    fontSize: 16,
    color: Colors.white,
  );

  static const fdButtonsGap = 20.0;

  static const fdHeroImageRadius = BorderRadius.all(Radius.circular(20));

  static final tsBackBtn = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        blurRadius: 5,
        offset: Offset(0, 2),
      ),
    ],
  );

  static const tsBackBtnText = TextStyle(
    color: Color(0xFF900603),
    fontWeight: FontWeight.bold,
  );

  static final tsBackBtnOutline = OutlinedButton.styleFrom(
    foregroundColor: Colors.white,
    side: BorderSide(color: Colors.white),
  );

  static final btnPrimary = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(50),
  );

  static const btnPrimaryText = TextStyle(
    color: Color(0xFF900603),
    fontWeight: FontWeight.w700,
  );

  static final btnOutline = BoxDecoration(
    color: Colors.transparent,
    border: Border.all(color: Colors.white, width: 2),
    borderRadius: BorderRadius.circular(50),
  );

  static const btnOutlineText = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w700,
  );

  static const fdCalculatorPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 80,
  );

  static const fdCalculatorTitle = TextStyle(
    fontSize: 32, // 2rem
    fontWeight: FontWeight.w700,
    color: Color(0xFF900603),
  );

  static final fdInputDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: Color(0xFFCCCCCC)),
  );

  // fd-card
  static final fdCard = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 20,
        offset: Offset(0, 4),
      ),
    ],
  );

  static const fdCardTitle = TextStyle(
    fontWeight: FontWeight.w600,
    color: Color(0xFF333333),
  );

  static const fdCardValue = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: Color(0xFF900603),
  );

  static const fdNote = TextStyle(fontSize: 14, color: Color(0xFF555555));

  // --------------------------------------------------------
  // Summary Card
  // --------------------------------------------------------
  static final fdSummaryCard = BoxDecoration(
    color: Color(0xFFFFF0F0),
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 20,
        offset: Offset(0, 4),
      ),
    ],
  );

  static const fdSummaryTitle = TextStyle(
    color: Color(0xFF900603),
    fontWeight: FontWeight.w700,
    fontSize: 20,
  );

  static const fdSummaryText = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );

  // --------------------------------------------------------
  // Benefits
  // --------------------------------------------------------
  static const fdBenefitsBackground = BoxDecoration(color: Color(0xFFF8F9FA));

  static const fdBenefitsPadding = EdgeInsets.all(20);

  static const fdBenefitsTitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );

  static final fdBenefitCard = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
    ],
  );

  static const fdBenefitCardTitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  // --------------------------------------------------------
  // CTA Section
  // --------------------------------------------------------
  static const fdCTAPadding = EdgeInsets.all(30);

  static const fdCTATitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  static const fdCTAButtonStyle = ButtonStyle(
    backgroundColor: MaterialStatePropertyAll(
      Color.fromARGB(255, 250, 249, 249),
    ),
    padding: MaterialStatePropertyAll(
      EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    ),
  );
}
