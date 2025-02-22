import 'package:finnhub_app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finnhub_app/theme/app_theme.dart';

void main() {
  group('AppTheme', () {
    testWidgets('currentTheme returns correct theme based on brightness', (tester) async {
      // Test dark theme
      await tester.pumpWidget(
        MaterialApp(
          builder: (context, child) {
            // Override brightness to force dark mode
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(platformBrightness: Brightness.dark),
              child: child!,
            );
          },
          home: Builder(
            builder: (context) {
              final theme = AppTheme.currentTheme(context);

              // Verify theme properties
              expect(theme.brightness, equals(Brightness.dark));
              expect(theme.scaffoldBackgroundColor, equals(backgroundDark));

              return const SizedBox();
            },
          ),
        ),
      );

      // Test light theme
      await tester.pumpWidget(
        MaterialApp(
          builder: (context, child) {
            // Override brightness to force dark mode
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(platformBrightness: Brightness.light),
              child: child!,
            );
          },
          home: Builder(
            builder: (context) {
              final theme = AppTheme.currentTheme(context);

              // Verify theme properties
              expect(theme.brightness, equals(Brightness.light));
              expect(theme.scaffoldBackgroundColor, equals(backgroundLight));

              return const SizedBox();
            },
          ),
        ),
      );
    });
  });
}
