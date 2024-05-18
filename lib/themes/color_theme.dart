import 'package:flutter/material.dart';

class MaterialTheme {

  const MaterialTheme(this.textTheme);
  final TextTheme textTheme;

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff415e91),
      surfaceTint: Color(0xff415e91),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffd7e3ff),
      onPrimaryContainer: Color(0xff001b3f),
      secondary: Color(0xff7b580d),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffffdeaa),
      onSecondaryContainer: Color(0xff271900),
      tertiary: Color(0xff2b638b),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffcce5ff),
      onTertiaryContainer: Color(0xff001e31),
      error: Color(0xff904a45),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff3b0908),
      background: Color(0xfff9f9ff),
      onBackground: Color(0xff191c20),
      surface: Color(0xfff5fafb),
      onSurface: Color(0xff171d1e),
      surfaceVariant: Color(0xffdbe4e6),
      onSurfaceVariant: Color(0xff3f484a),
      outline: Color(0xff6f797a),
      outlineVariant: Color(0xffbfc8ca),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3133),
      inverseOnSurface: Color(0xffecf2f3),
      inversePrimary: Color(0xffabc7ff),
      primaryFixed: Color(0xffd7e3ff),
      onPrimaryFixed: Color(0xff001b3f),
      primaryFixedDim: Color(0xffabc7ff),
      onPrimaryFixedVariant: Color(0xff284777),
      secondaryFixed: Color(0xffffdeaa),
      onSecondaryFixed: Color(0xff271900),
      secondaryFixedDim: Color(0xffefbf6d),
      onSecondaryFixedVariant: Color(0xff5f4100),
      tertiaryFixed: Color(0xffcce5ff),
      onTertiaryFixed: Color(0xff001e31),
      tertiaryFixedDim: Color(0xff98ccf9),
      onTertiaryFixedVariant: Color(0xff064b72),
      surfaceDim: Color(0xffd5dbdc),
      surfaceBright: Color(0xfff5fafb),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f6),
      surfaceContainer: Color(0xffe9eff0),
      surfaceContainerHigh: Color(0xffe3e9ea),
      surfaceContainerHighest: Color(0xffdee3e5),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff244373),
      surfaceTint: Color(0xff415e91),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff5875a9),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff5a3e00),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff946e24),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff00476d),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff4579a3),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff6e302b),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffaa6059),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfff9f9ff),
      onBackground: Color(0xff191c20),
      surface: Color(0xfff5fafb),
      onSurface: Color(0xff171d1e),
      surfaceVariant: Color(0xffdbe4e6),
      onSurfaceVariant: Color(0xff3b4446),
      outline: Color(0xff576162),
      outlineVariant: Color(0xff737c7e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3133),
      inverseOnSurface: Color(0xffecf2f3),
      inversePrimary: Color(0xffabc7ff),
      primaryFixed: Color(0xff5875a9),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff3f5c8e),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff946e24),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff79560a),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff4579a3),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff286088),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd5dbdc),
      surfaceBright: Color(0xfff5fafb),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f6),
      surfaceContainer: Color(0xffe9eff0),
      surfaceContainerHigh: Color(0xffe3e9ea),
      surfaceContainerHighest: Color(0xffdee3e5),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff00214b),
      surfaceTint: Color(0xff415e91),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff244373),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff301f00),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff5a3e00),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff00243b),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff00476d),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff44100e),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff6e302b),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfff9f9ff),
      onBackground: Color(0xff191c20),
      surface: Color(0xfff5fafb),
      onSurface: Color(0xff000000),
      surfaceVariant: Color(0xffdbe4e6),
      onSurfaceVariant: Color(0xff1c2527),
      outline: Color(0xff3b4446),
      outlineVariant: Color(0xff3b4446),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3133),
      inverseOnSurface: Color(0xffffffff),
      inversePrimary: Color(0xffe5ecff),
      primaryFixed: Color(0xff244373),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff052c5b),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff5a3e00),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff3d2900),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff00476d),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff002f4b),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd5dbdc),
      surfaceBright: Color(0xfff5fafb),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f6),
      surfaceContainer: Color(0xffe9eff0),
      surfaceContainerHigh: Color(0xffe3e9ea),
      surfaceContainerHighest: Color(0xffdee3e5),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffabc7ff),
      surfaceTint: Color(0xffabc7ff),
      onPrimary: Color(0xff0b305f),
      primaryContainer: Color(0xff284777),
      onPrimaryContainer: Color(0xffd7e3ff),
      secondary: Color(0xffefbf6d),
      onSecondary: Color(0xff422c00),
      secondaryContainer: Color(0xff5f4100),
      onSecondaryContainer: Color(0xffffdeaa),
      tertiary: Color(0xff98ccf9),
      onTertiary: Color(0xff003351),
      tertiaryContainer: Color(0xff064b72),
      onTertiaryContainer: Color(0xffcce5ff),
      error: Color(0xffffb3ac),
      onError: Color(0xff571e1a),
      errorContainer: Color(0xff73332f),
      onErrorContainer: Color(0xffffdad6),
      background: Color(0xff111318),
      onBackground: Color(0xffe2e2e9),
      surface: Color(0xff0e1415),
      onSurface: Color(0xffdee3e5),
      surfaceVariant: Color(0xff3f484a),
      onSurfaceVariant: Color(0xffbfc8ca),
      outline: Color(0xff899294),
      outlineVariant: Color(0xff3f484a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e5),
      inverseOnSurface: Color(0xff2b3133),
      inversePrimary: Color(0xff415e91),
      primaryFixed: Color(0xffd7e3ff),
      onPrimaryFixed: Color(0xff001b3f),
      primaryFixedDim: Color(0xffabc7ff),
      onPrimaryFixedVariant: Color(0xff284777),
      secondaryFixed: Color(0xffffdeaa),
      onSecondaryFixed: Color(0xff271900),
      secondaryFixedDim: Color(0xffefbf6d),
      onSecondaryFixedVariant: Color(0xff5f4100),
      tertiaryFixed: Color(0xffcce5ff),
      onTertiaryFixed: Color(0xff001e31),
      tertiaryFixedDim: Color(0xff98ccf9),
      onTertiaryFixedVariant: Color(0xff064b72),
      surfaceDim: Color(0xff0e1415),
      surfaceBright: Color(0xff343a3b),
      surfaceContainerLowest: Color(0xff090f10),
      surfaceContainerLow: Color(0xff171d1e),
      surfaceContainer: Color(0xff1b2122),
      surfaceContainerHigh: Color(0xff252b2c),
      surfaceContainerHighest: Color(0xff303637),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffb1cbff),
      surfaceTint: Color(0xffabc7ff),
      onPrimary: Color(0xff001635),
      primaryContainer: Color(0xff7491c7),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfff3c370),
      onSecondary: Color(0xff201400),
      secondaryContainer: Color(0xffb48a3d),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xff9dd0fe),
      onTertiary: Color(0xff001829),
      tertiaryContainer: Color(0xff6296c0),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab3),
      onError: Color(0xff330404),
      errorContainer: Color(0xffcc7b74),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff111318),
      onBackground: Color(0xffe2e2e9),
      surface: Color(0xff0e1415),
      onSurface: Color(0xfff6fcfd),
      surfaceVariant: Color(0xff3f484a),
      onSurfaceVariant: Color(0xffc3ccce),
      outline: Color(0xff9ba5a6),
      outlineVariant: Color(0xff7b8587),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e5),
      inverseOnSurface: Color(0xff252b2c),
      inversePrimary: Color(0xff294879),
      primaryFixed: Color(0xffd7e3ff),
      onPrimaryFixed: Color(0xff00112b),
      primaryFixedDim: Color(0xffabc7ff),
      onPrimaryFixedVariant: Color(0xff143665),
      secondaryFixed: Color(0xffffdeaa),
      onSecondaryFixed: Color(0xff1a0f00),
      secondaryFixedDim: Color(0xffefbf6d),
      onSecondaryFixedVariant: Color(0xff493200),
      tertiaryFixed: Color(0xffcce5ff),
      onTertiaryFixed: Color(0xff001321),
      tertiaryFixedDim: Color(0xff98ccf9),
      onTertiaryFixedVariant: Color(0xff00395a),
      surfaceDim: Color(0xff0e1415),
      surfaceBright: Color(0xff343a3b),
      surfaceContainerLowest: Color(0xff090f10),
      surfaceContainerLow: Color(0xff171d1e),
      surfaceContainer: Color(0xff1b2122),
      surfaceContainerHigh: Color(0xff252b2c),
      surfaceContainerHighest: Color(0xff303637),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffbfaff),
      surfaceTint: Color(0xffabc7ff),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffb1cbff),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfffffaf7),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xfff3c370),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfff9fbff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xff9dd0fe),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab3),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff111318),
      onBackground: Color(0xffe2e2e9),
      surface: Color(0xff0e1415),
      onSurface: Color(0xffffffff),
      surfaceVariant: Color(0xff3f484a),
      onSurfaceVariant: Color(0xfff3fcfe),
      outline: Color(0xffc3ccce),
      outlineVariant: Color(0xffc3ccce),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e5),
      inverseOnSurface: Color(0xff000000),
      inversePrimary: Color(0xff012959),
      primaryFixed: Color(0xffdde7ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffb1cbff),
      onPrimaryFixedVariant: Color(0xff001635),
      secondaryFixed: Color(0xffffe3b8),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xfff3c370),
      onSecondaryFixedVariant: Color(0xff201400),
      tertiaryFixed: Color(0xffd4e9ff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xff9dd0fe),
      onTertiaryFixedVariant: Color(0xff001829),
      surfaceDim: Color(0xff0e1415),
      surfaceBright: Color(0xff343a3b),
      surfaceContainerLowest: Color(0xff090f10),
      surfaceContainerLow: Color(0xff171d1e),
      surfaceContainer: Color(0xff1b2122),
      surfaceContainerHigh: Color(0xff252b2c),
      surfaceContainerHighest: Color(0xff303637),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary,
    required this.surfaceTint,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.inverseOnSurface,
    required this.inversePrimary,
    required this.primaryFixed,
    required this.onPrimaryFixed,
    required this.primaryFixedDim,
    required this.onPrimaryFixedVariant,
    required this.secondaryFixed,
    required this.onSecondaryFixed,
    required this.secondaryFixedDim,
    required this.onSecondaryFixedVariant,
    required this.tertiaryFixed,
    required this.onTertiaryFixed,
    required this.tertiaryFixedDim,
    required this.onTertiaryFixedVariant,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      surface: surface,
      onSurface: onSurface,
      surfaceContainerHighest: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
}

class ExtendedColor {

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
  final Color seed;
  final Color value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
