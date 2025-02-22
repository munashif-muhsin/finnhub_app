import 'package:finnhub_app/features/exchange_symbols/presentation/components/exchange_symbol_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finnhub_app/features/exchange_symbols/models/exchange_symbol_model.dart';

void main() {
  group('ForexSymbolWidget', () {
    testWidgets('displays symbol information correctly', (tester) async {
      final symbol = ExchangeSymbol(
        description: 'Euro/US Dollar',
        displaySymbol: 'EUR/USD',
        symbol: 'EUR/USD:FOREX',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExchangeSymbolWidget(symbol: symbol),
          ),
        ),
      );

      expect(find.text(symbol.displaySymbol), findsOneWidget);
      expect(find.text(symbol.description), findsOneWidget);
      expect(find.byIcon(Icons.keyboard_arrow_up), findsOneWidget);
    });
  });
}
