import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF006A6A),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFF6FF7F6),
  onPrimaryContainer: Color(0xFF002020),
  secondary: Color(0xFF006874),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFF97F0FF),
  onSecondaryContainer: Color(0xFF001F24),
  tertiary: Color(0xFF984061),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFFFD9E2),
  onTertiaryContainer: Color(0xFF3E001D),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFF8FDFF),
  onBackground: Color(0xFF001F25),
  surface: Color(0xFFF8FDFF),
  onSurface: Color(0xFF001F25),
  surfaceVariant: Color(0xFFDAE5E4),
  onSurfaceVariant: Color(0xFF3F4948),
  outline: Color(0xFF6F7979),
  onInverseSurface: Color(0xFFD6F6FF),
  inverseSurface: Color(0xFF00363F),
  inversePrimary: Color(0xFF4CDADA),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF006A6A),
  outlineVariant: Color(0xFFBEC9C8),
  scrim: Color(0xFF000000),
);

ThemeData lightTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    fontFamily: 'DMSans',
    // ==============[ BOTTOM NAVIGATION BAR ]==============
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
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
