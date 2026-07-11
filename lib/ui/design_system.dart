import 'package:flutter/material.dart';

class DesignSystem {
  // 8pt spacing grid
  static const double kSpace2 = 2;
  static const double kSpace4 = 4;
  static const double kSpace8 = 8;
  static const double kSpace12 = 12;
  static const double kSpace16 = 16;
  static const double kSpace24 = 24;
  static const double kSpace32 = 32;
  static const double kSpace48 = 48;
  static const double kSpace64 = 64;

  // Border radius
  static const double kRadiusSmall = 8;
  static const double kRadiusStandard = 16;
  static const double kRadiusCard = 24;
  static const double kRadiusCircular = 999;

  // Card elevation
  static const double kElevationLow = 0;
  static const double kElevationMedium = 4;
  static const double kElevationHigh = 8;

  // Blur values for glassmorphism
  static const double kBlurLight = 10;
  static const double kBlurMedium = 20;
  static const double kBlurHeavy = 30;

  // Animation durations
  static const Duration kDurationFast = Duration(milliseconds: 200);
  static const Duration kDurationNormal = Duration(milliseconds: 300);
  static const Duration kDurationSlow = Duration(milliseconds: 600);

  // Spring curves
  static const Curve kSpringCurve = Curves.easeInOutCubic;
  static const Curve kSpringBouncy = Curves.elasticOut;

  // Glass card shadow (dark theme)
  static List<BoxShadow> get kGlassShadowDark => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.3),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.15),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ];

  // Glass card shadow (light theme)
  static List<BoxShadow> get kGlassShadowLight => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.06),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ];

  // Navigation
  static const double kNavRailWidth = 72;
  static const double kNavRailExtendedWidth = 200;
  static const double kMiniPlayerHeight = 64;
  static const double kBottomNavHeight = 64;

  // Icon sizes
  static const double kIconSmall = 16;
  static const double kIconMedium = 24;
  static const double kIconLarge = 32;

  // Typography
  static const double kTextXs = 12;
  static const double kTextSm = 14;
  static const double kTextBase = 16;
  static const double kTextLg = 18;
  static const double kTextXl = 20;
  static const double kText2xl = 24;
  static const double kText3xl = 32;
}
