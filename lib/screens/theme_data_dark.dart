import 'package:clashmi/screens/theme_define.dart';
import 'package:flutter/material.dart';

class ThemeDataDark {
  static ThemeData theme(BuildContext context) {
    final ColorScheme scheme = ColorScheme.dark(
      primary: ThemeDefine.kPrimary,
      secondary: ThemeDefine.kAccent,
      surface: ThemeDefine.kSurface,
      error: ThemeDefine.kError,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: ThemeDefine.kTextPrimary,
      onError: Colors.white,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      platform: TargetPlatform.iOS,
      scaffoldBackgroundColor: ThemeDefine.kBackground,
      brightness: Brightness.dark,
      cardTheme: CardThemeData(
        color: ThemeDefine.kGlassDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ThemeDefine.kGlassDark,
        labelStyle: TextStyle(color: ThemeDefine.kTextSecondary),
        floatingLabelStyle: TextStyle(color: ThemeDefine.kPrimary),
        hintStyle: TextStyle(color: ThemeDefine.kTextSecondary),
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
          borderSide: BorderSide(color: ThemeDefine.kPrimary.withValues(alpha: 0.5)),
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
        color: Colors.white.withValues(alpha: 0.06),
        thickness: 1,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ThemeDefine.kSurface,
        selectedItemColor: ThemeDefine.kPrimary,
        unselectedItemColor: ThemeDefine.kTextSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: ThemeDefine.kSurface,
        selectedIconTheme: IconThemeData(color: ThemeDefine.kPrimary),
        unselectedIconTheme: IconThemeData(color: ThemeDefine.kTextSecondary),
        selectedLabelTextStyle: TextStyle(
          color: ThemeDefine.kPrimary,
          fontSize: 12,
        ),
        unselectedLabelTextStyle: TextStyle(
          color: ThemeDefine.kTextSecondary,
          fontSize: 12,
        ),
        indicatorColor: ThemeDefine.kPrimary.withValues(alpha: 0.15),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: ThemeDefine.kSurface,
        contentTextStyle: const TextStyle(color: ThemeDefine.kTextPrimary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        behavior: SnackBarBehavior.floating,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: ThemeDefine.kSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: ThemeDefine.kSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),
    );
  }
}
