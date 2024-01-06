import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF00668A),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFC4E7FF),
  onPrimaryContainer: Color(0xFF001E2C),
  secondary: Color(0xFF00658B),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFC4E7FF),
  onSecondaryContainer: Color(0xFF001E2C),
  tertiary: Color(0xFF00658D),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFC6E7FF),
  onTertiaryContainer: Color(0xFF001E2D),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFF8FDFF),
  onBackground: Color(0xFF001F25),
  surface: Color(0xFFF8FDFF),
  onSurface: Color(0xFF001F25),
  surfaceVariant: Color(0xFFDCE3E9),
  onSurfaceVariant: Color(0xFF41484D),
  outline: Color(0xFF71787D),
  onInverseSurface: Color(0xFFD6F6FF),
  inverseSurface: Color(0xFF00363F),
  inversePrimary: Color(0xFF7BD0FF),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF00668A),
  outlineVariant: Color(0xFFC0C7CD),
  scrim: Color(0xFF000000),
);

ThemeData lightTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    fontFamily: 'DMSans',
    // ==============[ BOTTOM NAVIGATION BAR ]==============
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      backgroundColor: lightColorScheme.surface,
      selectedItemColor: lightColorScheme.primary,
      unselectedItemColor: lightColorScheme.onSurfaceVariant.withOpacity(0.5),
      selectedIconTheme: IconThemeData(
        size: 24,
        color: lightColorScheme.primary,
      ),
      selectedLabelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: lightColorScheme.primary,
      ),
    ),
  );
}
