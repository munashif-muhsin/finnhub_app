import 'package:flutter/material.dart';

// Declared separately to test color theme.
const backgroundLight = Color(0xFFFFFFFF);
const backgroundDark = Color(0xFF000000);

final Color _success = Color(0xFF00C853);
final Color _failure = Color(0xFFFF3D00);
final Color _accent1 = Color(0xFF2962FF);
final Color _accent2 = Color(0xFFFFAB00);

class AppColors {
  // Global colors
  static get danger => _failure;

  final Color background;
  final Color surface;
  final Color surfaceLight;
  final Color textPrimary;
  final Color textSecondary;
  final Color textDisabled;
  final Color chartLine;
  final Color chartGrid;
  final Color primary;
  final Color secondary;
  final Color success;
  final Color failure;

  AppColors._({
    required this.background,
    required this.surface,
    required this.surfaceLight,
    required this.textPrimary,
    required this.textSecondary,
    required this.textDisabled,
    required this.chartLine,
    required this.chartGrid,
    required this.primary,
    required this.secondary,
    required this.success,
    required this.failure,
  });

  static AppColors of(BuildContext context) {
    return MediaQuery.platformBrightnessOf(context) == Brightness.dark
        ? AppColors._(
            background: backgroundDark,
            surface: Color(0xFF121212),
            surfaceLight: Color(0xFF242424),
            textPrimary: Color(0xFFFFFFFF),
            textSecondary: Color(0xFFB0B0B0),
            textDisabled: Color(0xFF666666),
            chartLine: Color(0xFF4CAF50),
            chartGrid: Color(0xFF2C2C2C),
            primary: _accent1,
            secondary: _accent2,
            success: _success,
            failure: _failure,
          )
        : AppColors._(
            background: backgroundLight,
            surface: Color(0xFFF5F5F5),
            surfaceLight: Color(0xFFE0E0E0),
            textPrimary: Color(0xFF000000),
            textSecondary: Color(0xFF666666),
            textDisabled: Color(0xFFAAAAAA),
            chartLine: Color(0xFF2E7D32),
            chartGrid: Color(0xFFE0E0E0),
            primary: _accent1,
            secondary: _accent2,
            success: _success,
            failure: _failure,
          );
  }
}
