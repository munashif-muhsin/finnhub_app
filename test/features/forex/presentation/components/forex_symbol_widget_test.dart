import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finnhub_app/features/forex/models/forex_symbol_model.dart';
import 'package:finnhub_app/features/forex/presentation/components/forex_symbol_widget.dart';

void main() {
  group('ForexSymbolWidget', () {
    testWidgets('displays symbol information correctly', (tester) async {
      final symbol = ForexSymbol(
        description: 'Euro/US Dollar',
        displaySymbol: 'EUR/USD',
        symbol: 'EUR/USD:FOREX',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ForexSymbolWidget(symbol: symbol),
          ),
        ),
      );

      expect(find.text(symbol.displaySymbol), findsOneWidget);
      expect(find.text(symbol.description), findsOneWidget);
      expect(find.byIcon(Icons.keyboard_arrow_up), findsOneWidget);
    });
  });
}
