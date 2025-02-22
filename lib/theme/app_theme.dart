import 'package:flutter/material.dart';
import 'package:finnhub_app/theme/colors.dart';
import 'package:finnhub_app/theme/text_theme.dart';

/// Manages the application's theme configurations
///
/// Provides light and dark theme implementations along with helper methods
/// to determine the current theme based on platform brightness
class AppTheme {
  /// Creates a light theme configuration for the application
  ///
  /// Uses [context] to access theme-related dependencies and returns
  /// a [ThemeData] configured for light mode
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

  /// Creates a dark theme configuration for the application
  ///
  /// Uses [context] to access theme-related dependencies and returns
  /// a [ThemeData] configured for dark mode
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

  /// Returns the appropriate theme based on the platform's brightness setting
  ///
  /// Uses [context] to determine the platform brightness and returns either
  /// [lightTheme] or [darkTheme] accordingly
  static ThemeData currentTheme(BuildContext context) {
    return MediaQuery.platformBrightnessOf(context) == Brightness.dark ? darkTheme(context) : lightTheme(context);
  }
}
