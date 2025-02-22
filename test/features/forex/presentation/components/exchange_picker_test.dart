import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finnhub_app/features/forex/presentation/components/exchange_picker.dart';

void main() {
  group('ExchangePicker', () {
    testWidgets('displays selected exchange and opens sheet on tap and returns the exchange on selection',
        (tester) async {
      const selectedExchange = 'FOREX';
      const exchanges = ['FOREX', 'OANDA'];
      String? selectedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExchangePicker(
              selectedExchange: selectedExchange,
              exchanges: exchanges,
              onExchangeSelected: (value) => selectedValue = value,
            ),
          ),
        ),
      );

      expect(find.text('Exchange'), findsOneWidget);
      expect(find.text(selectedExchange.toUpperCase()), findsOneWidget);
      expect(find.byIcon(Icons.expand_circle_down_outlined), findsOneWidget);

      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      final sheet = find.byType(DraggableScrollableSheet);
      expect(sheet, findsOneWidget);

      // Find elements inside the sheet
      expect(
        find.descendant(
          of: sheet,
          matching: find.text('Select exchange'),
        ),
        findsOneWidget,
      );

      for (final exchange in exchanges) {
        expect(
          find.descendant(
            of: sheet,
            matching: find.text(exchange.toUpperCase()),
          ),
          findsOneWidget,
        );
      }

      await tester.tap(find.text(exchanges.last));
      await tester.pumpAndSettle();
      expect(exchanges.last, selectedValue);
    });
  });
}
