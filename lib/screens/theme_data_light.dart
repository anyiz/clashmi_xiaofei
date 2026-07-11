import 'package:clashmi/screens/theme_define.dart';
import 'package:flutter/material.dart';

class ThemeDataLight {
  static ThemeData theme(BuildContext context) {
    final ColorScheme scheme = ColorScheme.light(
      primary: ThemeDefine.kPrimary,
      secondary: ThemeDefine.kAccent,
      surface: ThemeDefine.kSurfaceLight,
      error: ThemeDefine.kError,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: const Color(0xFF1A1D26),
      onError: Colors.white,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      platform: TargetPlatform.iOS,
      scaffoldBackgroundColor: ThemeDefine.kSurfaceLight,
      brightness: Brightness.light,
      cardTheme: CardThemeData(
        color: ThemeDefine.kSurfaceLightCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ThemeDefine.kGlassLight,
        labelStyle: const TextStyle(color: Color(0xFF8B93A6)),
        floatingLabelStyle: TextStyle(color: ThemeDefine.kPrimary),
        hintStyle: const TextStyle(color: Color(0xFF8B93A6)),
        errorStyle: const TextStyle(color: Color(0xFFFF453A)),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ThemeDefine.kPrimary.withValues(alpha: 0.5),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      listTileTheme: ListTileThemeData(
        dense: true,
        tileColor: Colors.transparent,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            return ThemeDefine.kPrimary;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            return Colors.white;
          }),
          shape: WidgetStateProperty.resolveWith((states) {
            return RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            );
          }),
          padding: WidgetStateProperty.resolveWith((states) {
            return const EdgeInsets.symmetric(horizontal: 24, vertical: 14);
          }),
          elevation: WidgetStateProperty.resolveWith((states) => 0),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            return ThemeDefine.kPrimary;
          }),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return ThemeDefine.kPrimary;
          }
          return Colors.grey;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return ThemeDefine.kPrimary.withValues(alpha: 0.3);
          }
          return Colors.grey.withValues(alpha: 0.2);
        }),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return ThemeDefine.kPrimary;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.resolveWith((states) {
          return Colors.white;
        }),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        strokeWidth: 2,
        color: ThemeDefine.kPrimary,
      ),
      dividerTheme: DividerThemeData(
        color: Colors.black.withValues(alpha: 0.06),
        thickness: 1,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: ThemeDefine.kPrimary,
        unselectedItemColor: const Color(0xFF8B93A6),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: Colors.white,
        selectedIconTheme: IconThemeData(color: ThemeDefine.kPrimary),
        unselectedIconTheme: const IconThemeData(color: Color(0xFF8B93A6)),
        selectedLabelTextStyle: TextStyle(
          color: ThemeDefine.kPrimary,
          fontSize: 12,
        ),
        unselectedLabelTextStyle: const TextStyle(
          color: Color(0xFF8B93A6),
          fontSize: 12,
        ),
        indicatorColor: ThemeDefine.kPrimary.withValues(alpha: 0.1),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: const Color(0xFF1A1D26),
        contentTextStyle: const TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        behavior: SnackBarBehavior.floating,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),
    );
  }
}
