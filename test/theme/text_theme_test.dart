import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finnhub_app/theme/text_theme.dart';

void main() {
  group('AppTextTheme', () {
    testWidgets('provides correct text styles', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final textTheme = AppTextTheme.getTheme(context);

              expect(textTheme.displayLarge?.fontSize, 32);
              expect(textTheme.bodyLarge?.fontSize, 16);
              expect(textTheme.labelMedium?.fontSize, 12);

              return const SizedBox();
            },
          ),
        ),
      );
    });
  });
}
