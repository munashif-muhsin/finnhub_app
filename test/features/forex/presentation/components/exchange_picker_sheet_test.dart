import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finnhub_app/features/forex/presentation/components/exchange_picker_sheet.dart';

void main() {
  group('ExchangePickerSheet', () {
    testWidgets('displays exchanges list and handles selection', (tester) async {
      final exchanges = ['FOREX', 'OANDA', 'Test Exchange'];
      String? selectedExchange;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExchangePickerSheet(
              exchanges: exchanges,
              onExchangeSelected: (exchange) => selectedExchange = exchange,
              scrollController: ScrollController(),
            ),
          ),
        ),
      );

      expect(find.text('Select exchange'), findsOneWidget);

      for (final exchange in exchanges) {
        expect(find.text(exchange.toUpperCase()), findsOneWidget);
      }

      await tester.tap(find.text(exchanges.last.toUpperCase()));
      expect(selectedExchange, equals(exchanges.last));
    });
  });
}
