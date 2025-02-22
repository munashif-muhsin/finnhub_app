import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finnhub_app/theme/colors.dart';

void main() {
  group('AppColors', () {
    testWidgets('provides dark theme colors when brightness is dark', (tester) async {
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
              final colors = AppColors.of(context);
              expect(colors.background, equals(backgroundDark));
              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('provides light theme colors when brightness is light', (tester) async {
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
              final colors = AppColors.of(context);
              expect(colors.background, equals(backgroundLight));
              return const SizedBox();
            },
          ),
        ),
      );
    });
  });
}
