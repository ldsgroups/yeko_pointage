import 'package:flutter/material.dart';

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF4CDADA),
  onPrimary: Color(0xFF003737),
  primaryContainer: Color(0xFF004F4F),
  onPrimaryContainer: Color(0xFF6FF7F6),
  secondary: Color(0xFF4FD8EB),
  onSecondary: Color(0xFF00363D),
  secondaryContainer: Color(0xFF004F58),
  onSecondaryContainer: Color(0xFF97F0FF),
  tertiary: Color(0xFFFFB1C8),
  onTertiary: Color(0xFF5E1133),
  tertiaryContainer: Color(0xFF7B2949),
  onTertiaryContainer: Color(0xFFFFD9E2),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF001F25),
  onBackground: Color(0xFFA6EEFF),
  surface: Color(0xFF001F25),
  onSurface: Color(0xFFA6EEFF),
  surfaceVariant: Color(0xFF3F4948),
  onSurfaceVariant: Color(0xFFBEC9C8),
  outline: Color(0xFF889392),
  onInverseSurface: Color(0xFF001F25),
  inverseSurface: Color(0xFFA6EEFF),
  inversePrimary: Color(0xFF006A6A),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF4CDADA),
  outlineVariant: Color(0xFF3F4948),
  scrim: Color(0xFF000000),
);

ThemeData darkTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: darkColorScheme,
    fontFamily: 'DMSans',
    // ==============[ BOTTOM NAVIGATION BAR ]==============
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      backgroundColor: darkColorScheme.surface,
      selectedItemColor: darkColorScheme.primary,
      unselectedItemColor: darkColorScheme.onSurfaceVariant.withOpacity(0.5),
      selectedIconTheme: IconThemeData(
        size: 24,
        color: darkColorScheme.primary,
      ),
      selectedLabelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: darkColorScheme.primary,
      ),
    ),
    // ==
  );
}
