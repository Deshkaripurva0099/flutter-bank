// fd_styles.dart
import 'package:flutter/material.dart';

class FDColors {
  static const Color primary = Color(0xFF900603);
  static const Color white = Colors.white;
  static const Color background = Color(0xFFF8F9FA);
  static const Color textDark = Colors.black87;
  static const Color textLight = Colors.white;
  static const Color gray = Color(0xFFEEEEEE);
  static const Color success = Color(0xFF28A745);
}

class FDTextStyles {
  static const TextStyle h1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    fontFamily: 'Inter',
    color: Colors.white,
  );

  static const TextStyle h4 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    fontFamily: 'Inter',
    color: Colors.white,
  );

  static const TextStyle paragraph = TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontFamily: 'Inter',
  );

  static const TextStyle smallNote = TextStyle(
    fontSize: 14,
    color: Colors.black54,
    fontFamily: 'Inter',
  );

  static const TextStyle summaryValue = TextStyle(
    color: FDColors.primary,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    fontFamily: 'Inter',
  );
}

class FDButtonStyles {
  static ButtonStyle primaryButton = ElevatedButton.styleFrom(
    backgroundColor: FDColors.primary,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    textStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      fontFamily: 'Inter',
    ),
  );

  static ButtonStyle whitePrimaryButton = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: FDColors.primary,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    textStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      fontFamily: 'Inter',
    ),
  );

  static ButtonStyle outlineButton = OutlinedButton.styleFrom(
    side: const BorderSide(color: FDColors.white, width: 2),
    foregroundColor: FDColors.white,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    textStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      fontFamily: 'Inter',
    ),
  );

  static ButtonStyle outlineDarkButton = OutlinedButton.styleFrom(
    side: const BorderSide(color: FDColors.primary, width: 2),
    foregroundColor: FDColors.primary,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    textStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      fontFamily: 'Inter',
    ),
  );
}

class FDBoxDecorations {
  static BoxDecoration heroBackground = const BoxDecoration(
    color: FDColors.primary,
  );

  static BoxDecoration card = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 2)),
    ],
  );

  static BoxDecoration tab(bool active) => BoxDecoration(
    color: active ? FDColors.primary : FDColors.gray,
    borderRadius: BorderRadius.circular(8),
  );

  static BoxDecoration slab(bool active) => BoxDecoration(
    color: active ? FDColors.primary : FDColors.gray,
    borderRadius: BorderRadius.circular(8),
  );

  static BoxDecoration summaryCard = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: const [
      BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2)),
    ],
  );

  static BoxDecoration benefitCard = BoxDecoration(
    color: FDColors.background,
    borderRadius: BorderRadius.circular(12),
    boxShadow: const [
      BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
    ],
  );
}

class FDPaddings {
  static const EdgeInsets section = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 50,
  );
  static const EdgeInsets cardBody = EdgeInsets.all(20);
  static const EdgeInsets hero = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 0,
  );
}

class FDMargins {
  static const EdgeInsets gap20 = EdgeInsets.all(20);
  static const EdgeInsets gap10 = EdgeInsets.all(10);
}

class FDBorders {
  static Border whiteBorder = Border.all(color: Colors.white, width: 2);
  static Border primaryBorder = Border.all(color: FDColors.primary, width: 2);
}

class FDShadows {
  static List<BoxShadow> light = [
    BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 2)),
  ];
}

// Variables used in the code
const Color fdPrimaryColor = FDColors.primary;
const Color fdBackgroundColor = FDColors.background;
const TextStyle fdTitleText = FDTextStyles.h1;
const TextStyle fdSubTitleText = FDTextStyles.h4;
const TextStyle fdBodyText = FDTextStyles.paragraph;
const TextStyle fdSummaryLabelText = FDTextStyles.smallNote;
const TextStyle fdSummaryValueText = FDTextStyles.summaryValue;
const TextStyle fdDarkBodyText = TextStyle(
  fontSize: 16,
  color: Colors.black87,
  fontFamily: 'Inter',
);
const TextStyle fdCardHeaderText = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: Colors.white,
  fontFamily: 'Inter',
);
const TextStyle fdBenefitTitle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: Colors.black87,
  fontFamily: 'Inter',
);
const TextStyle fdBenefitDesc = TextStyle(
  fontSize: 14,
  color: Colors.black54,
  fontFamily: 'Inter',
);

const EdgeInsets fdSectionPadding = FDPaddings.section;
const EdgeInsets fdCardPadding = FDPaddings.cardBody;
const EdgeInsets fdHeroPadding = FDPaddings.hero;

BoxDecoration fdHeroDecoration = FDBoxDecorations.heroBackground;
BoxDecoration fdCardDecoration = FDBoxDecorations.card;
BoxDecoration fdSummaryDecoration = FDBoxDecorations.summaryCard;
BoxDecoration fdBenefitCardDecoration = FDBoxDecorations.benefitCard;

ButtonStyle fdPrimaryButton = FDButtonStyles.primaryButton;
ButtonStyle fdOutlineButton = FDButtonStyles.outlineButton;
