import 'dart:io';

import 'package:flutter/material.dart';

class ThemeConfig {
  // Navigation heights
  static const double kNavigationRailWidth = 72;
  static const double kNavigationRailExtendedWidth = 200;

  // Card dimensions
  static const double kTrafficCardWidth = 140;
  static const double kTrafficCardHeight = 100;
  static const double kNodeCardHeight = 88;
  static const double kStatusCardHeight = 80;

  // Font sizes
  static const double kFontSizeTitle = 18;
  static const FontWeight kFontWeightTitle = FontWeight.w600;

  static const double kFontSizeListItem = 17;
  static const FontWeight kFontWeightListItem = FontWeight.w500;

  static const double kFontSizeListSubItem = 14;
  static const FontWeight kFontWeightListSubItem = FontWeight.w400;

  static double kFontSizeGroupItem = (Platform.isAndroid || Platform.isIOS)
      ? 15
      : 14;
  static const FontWeight kFontWeightGroupItem = FontWeight.w400;

  // Legacy layout constants
  static const double kListItemHeight2 = 52;
  static const double kGroupItemHeight = 48;
}
