import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finnhub_app/features/common/widgets/error_retry_widget.dart';

void main() {
  group('ErrorRetryWidget', () {
    testWidgets('shows error message and retry button', (tester) async {
      bool retryPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: ErrorRetryWidget(
            onRetry: () => retryPressed = true,
          ),
        ),
      );

      expect(find.text('An error occurred. Please try again.'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);

      await tester.tap(find.byType(ElevatedButton));
      expect(retryPressed, true);
    });

    testWidgets('shows custom error message when provided', (tester) async {
      const customMessage = 'Custom error message';

      await tester.pumpWidget(
        MaterialApp(
          home: ErrorRetryWidget(
            message: customMessage,
            onRetry: () {},
          ),
        ),
      );

      expect(find.text(customMessage), findsOneWidget);
    });
  });
}
