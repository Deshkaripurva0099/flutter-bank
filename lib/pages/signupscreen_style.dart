import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SignupScreenStyle {
  /* ===================== Container ===================== */
  static const LinearGradient containerGradient = LinearGradient(
    colors: [Color(0xFF900603), Color(0xFF0f172a), Color(0xFF900603)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const EdgeInsets containerPadding = EdgeInsets.all(6);

  static const TextStyle globalFont = TextStyle(fontFamily: 'Segoe UI');

  // Animation equivalent placeholder (fade-in)
  static final fadeInBackground = CurvedAnimation(
    parent: AnimationController(
      vsync: const _NoTickerProvider(),
      duration: Duration(milliseconds: 1500),
    ),
    curve: Curves.easeIn,
  );

  /* ===================== Back/Next Buttons ===================== */
  static final ButtonStyle navButton = TextButton.styleFrom(
    foregroundColor: Colors.white,
    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    padding: EdgeInsets.zero,
  );

  static const navButtonHoverColor = Color(0xFFFFB3B3);

  /* ===================== Card ===================== */
  static const BoxDecoration cardDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xFF900603), Color(0xFF0f172a), Color(0xFF900603)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.all(Radius.circular(24)),
    boxShadow: [
      BoxShadow(color: Colors.black54, blurRadius: 50, offset: Offset(0, 20)),
    ],
    border: Border.fromBorderSide(
      BorderSide(color: Color.fromRGBO(255, 255, 255, 0.2)),
    ),
  );

  static const EdgeInsets cardPadding = EdgeInsets.symmetric(
    vertical: 40,
    horizontal: 32,
  );

  /* ===================== Header ===================== */
  static const TextStyle titleText = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle subtitleText = TextStyle(
    fontSize: 16,
    color: Color(0xFFFFE6E6),
  );

  /* ===================== Form ===================== */
  static const TextStyle labelText = TextStyle(
    color: Color(0xFFFFE6E6),
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static final InputDecoration inputDecoration = InputDecoration(
    filled: true,
    fillColor: Color.fromRGBO(255, 255, 255, 0.05),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: Color.fromRGBO(255, 255, 255, 0.1)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: Color(0xFFFF9999)),
    ),
    contentPadding: EdgeInsets.all(16),
    hintStyle: TextStyle(
      color: Color.fromRGBO(255, 255, 255, 0.6),
      fontSize: 16,
    ),
  );

  /* ===================== Continue Button ===================== */
  // Flutter version of `.signupscreen-continue-btn`
  static final ButtonStyle continueButton = ElevatedButton.styleFrom(
    backgroundColor: const Color(
      0xFF900603,
    ).withOpacity(0.5), // faint red background
    foregroundColor: Colors.white, // white text
    shadowColor: const Color.fromRGBO(145, 5, 5, 0.712),
    elevation: 12,
    padding: const EdgeInsets.symmetric(vertical: 16),
    minimumSize: const Size(double.infinity, 54),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  ).merge(ButtonStyle(overlayColor: MaterialStateProperty.all(Colors.white24)));

  // Wrapper decoration for gradient effect
  static const BoxDecoration continueButtonDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xFF900603), Color(0xFF900603)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.all(Radius.circular(14)),
    boxShadow: [
      BoxShadow(
        color: Color.fromRGBO(145, 5, 5, 0.7),
        blurRadius: 12,
        offset: Offset(0, 6),
      ),
    ],
  );

  /* ===================== Terms Text ===================== */
  static const TextStyle termsText = TextStyle(
    fontSize: 12,
    color: Color(0xFFFFB3B3),
    height: 1.4,
  );

  /* ===================== Responsive adjustments ===================== */
  static double responsiveTitleFont(double width) {
    if (width < 480) return 24;
    if (width < 768) return 28;
    return 32;
  }

  static double responsiveSubtitleFont(double width) {
    if (width < 480) return 13;
    if (width < 768) return 14;
    return 16;
  }

  static EdgeInsets responsiveCardPadding(double width) {
    if (width < 480) {
      return const EdgeInsets.symmetric(vertical: 24, horizontal: 16);
    }
    if (width < 768) {
      return const EdgeInsets.symmetric(vertical: 32, horizontal: 24);
    }
    return const EdgeInsets.symmetric(vertical: 40, horizontal: 32);
  }

  static double responsiveInputPadding(double width) {
    if (width < 480) return 12;
    if (width < 768) return 14;
    return 16;
  }

  static double responsiveButtonFontSize(double width) {
    if (width < 480) return 14;
    if (width < 768) return 15;
    return 16;
  }
}

/* 
Helper for animation controller in static context.
Used to replicate fadeIn keyframes placeholder.
*/
class _NoTickerProvider extends StatelessWidget implements TickerProvider {
  const _NoTickerProvider({super.key});
  @override
  Ticker createTicker(onTick) => Ticker(onTick);
  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
