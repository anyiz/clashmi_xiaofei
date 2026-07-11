import 'package:flutter/material.dart';

class ThemeDefine {
  // Premium palette
  static const Color kBackground = Color(0xFF090B12);
  static const Color kSurface = Color(0xFF151923);
  static const Color kPrimary = Color(0xFF5B7FFF);
  static const Color kAccent = Color(0xFF8A5CFF);
  static const Color kSuccess = Color(0xFF30D158);
  static const Color kWarning = Color(0xFFFFB340);
  static const Color kError = Color(0xFFFF453A);
  static const Color kTextPrimary = Color(0xFFFFFFFF);
  static const Color kTextSecondary = Color(0xFF8B93A6);

  static const Color kSurfaceLight = Color(0xFFF5F6FA);
  static const Color kSurfaceLightCard = Color(0xFFFFFFFF);

  // Glass colors
  static Color kGlassDark = const Color(0xFF151923).withValues(alpha: 0.6);
  static Color kGlassLight = const Color(0xFFFFFFFF).withValues(alpha: 0.7);
  static Color kGlassBorderDark =
      const Color(0xFFFFFFFF).withValues(alpha: 0.08);
  static Color kGlassBorderLight =
      const Color(0xFF000000).withValues(alpha: 0.06);

  // Gradient
  static const LinearGradient kPrimaryGradient = LinearGradient(
    colors: [kPrimary, kAccent],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const List<Color> kBreathingGlowColors = [
    Color(0xFF5B7FFF),
    Color(0xFF8A5CFF),
    Color(0xFF30D158),
  ];

  // Theme mode keys
  static const String kThemeSystem = "system";
  static const String kThemeLight = "light";
  static const String kThemeDark = "dark";

  // Legacy colors (used by existing screens)
  static const Color kColorBlue = Color(0xFF5B7FFF);
  static const Color kColorGreenBright = Color(0xFF30D158);

  // Legacy border radius
  static const BorderRadiusGeometry kBorderRadius = BorderRadius.all(Radius.circular(12));
}
