import 'package:flutter/material.dart';

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF7BD0FF),
  onPrimary: Color(0xFF003549),
  primaryContainer: Color(0xFF004C69),
  onPrimaryContainer: Color(0xFFC4E7FF),
  secondary: Color(0xFF7DD0FF),
  onSecondary: Color(0xFF00344A),
  secondaryContainer: Color(0xFF004C69),
  onSecondaryContainer: Color(0xFFC4E7FF),
  tertiary: Color(0xFF82CFFF),
  onTertiary: Color(0xFF00344B),
  tertiaryContainer: Color(0xFF004C6B),
  onTertiaryContainer: Color(0xFFC6E7FF),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF001F25),
  onBackground: Color(0xFFA6EEFF),
  surface: Color(0xFF001F25),
  onSurface: Color(0xFFA6EEFF),
  surfaceVariant: Color(0xFF41484D),
  onSurfaceVariant: Color(0xFFC0C7CD),
  outline: Color(0xFF8B9297),
  onInverseSurface: Color(0xFF001F25),
  inverseSurface: Color(0xFFA6EEFF),
  inversePrimary: Color(0xFF00668A),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF7BD0FF),
  outlineVariant: Color(0xFF41484D),
  scrim: Color(0xFF000000),
);

ThemeData darkTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: darkColorScheme,
    fontFamily: 'DMSans',
    // ==============[ BOTTOM NAVIGATION BAR ]==============
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
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
