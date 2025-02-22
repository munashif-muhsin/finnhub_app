import 'package:flutter/material.dart';
import 'package:finnhub_app/theme/colors.dart';
import 'package:finnhub_app/theme/text_theme.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    final colors = AppColors.of(context);
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: colors.primary,
      scaffoldBackgroundColor: colors.background,
      colorScheme: ColorScheme.light(
        primary: colors.primary,
        secondary: colors.secondary,
        surface: colors.surface,
        error: colors.secondary,
      ),
      cardColor: colors.surface,
      textTheme: AppTextTheme.getTheme(context),
      iconTheme: IconThemeData(color: colors.textPrimary),
      appBarTheme: AppBarTheme(
        backgroundColor: colors.surface,
        foregroundColor: colors.textPrimary,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.textPrimary,
        ),
      ),
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    final colors = AppColors.of(context);
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: colors.primary,
      scaffoldBackgroundColor: colors.background,
      colorScheme: ColorScheme.dark(
        primary: colors.primary,
        secondary: colors.secondary,
        surface: colors.surface,
        error: colors.secondary,
      ),
      cardColor: colors.surface,
      textTheme: AppTextTheme.getTheme(context),
      iconTheme: IconThemeData(color: colors.textPrimary),
      appBarTheme: AppBarTheme(
        backgroundColor: colors.surface,
        foregroundColor: colors.textPrimary,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.textPrimary,
        ),
      ),
    );
  }

  static ThemeData currentTheme(BuildContext context) {
    return MediaQuery.platformBrightnessOf(context) == Brightness.dark ? darkTheme(context) : lightTheme(context);
  }
}
