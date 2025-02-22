import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finnhub_app/features/forex/presentation/components/exchange_sheet_item.dart';

void main() {
  group('ExchangeSheetItem', () {
    testWidgets('displays exchange name and arrow correctly', (tester) async {
      const exchange = 'forex';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ExchangeSheetItem(exchange: exchange),
          ),
        ),
      );

      expect(find.text(exchange.toUpperCase()), findsOneWidget);
      expect(find.byIcon(Icons.keyboard_arrow_right_outlined), findsOneWidget);
    });
  });
}
