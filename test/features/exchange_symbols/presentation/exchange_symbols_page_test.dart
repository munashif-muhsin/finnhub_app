import 'package:bloc_test/bloc_test.dart';
import 'package:finnhub_app/features/common/widgets/error_retry_widget.dart';
import 'package:finnhub_app/features/common/models/exchange_symbol_model.dart';
import 'package:finnhub_app/features/exchange_symbols/bloc/exchange_symbols_bloc.dart';
import 'package:finnhub_app/features/exchange_symbols/presentation/components/exchange_symbol_widget.dart';
import 'package:finnhub_app/features/exchange_symbols/presentation/exchange_symbols_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class MockForexBloc extends MockBloc<ExchangeSymbolsEvent, ExchangeSymbolsState> implements ExchangeSymbolsBloc {}

void main() {
  late MockForexBloc mockForexBloc;

  setUp(() {
    mockForexBloc = MockForexBloc();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<ExchangeSymbolsBloc>.value(
        value: mockForexBloc,
        child: const ExchangeSymbolsPage(),
      ),
    );
  }

  group('ForexPage', () {
    testWidgets('shows loading indicator when state is loading', (tester) async {
      whenListen(
        mockForexBloc,
        Stream.fromIterable([ExchangeSymbolsState.initial()]),
        initialState: ExchangeSymbolsState.initial(),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows error widget when state has error', (tester) async {
      whenListen(
        mockForexBloc,
        Stream.fromIterable([ExchangeSymbolsState.initial().copyWith(hasError: true, isLoading: false)]),
        initialState: ExchangeSymbolsState.initial(),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.byType(ErrorRetryWidget), findsOneWidget);
    });

    testWidgets('shows empty message when no symbols available', (tester) async {
      final state = ExchangeSymbolsState.initial().copyWith(
        exchanges: ['FOREX'],
        selectedExchange: 'FOREX',
        symbols: [],
        isLoading: false,
        isSymbolsLoading: false,
      );

      whenListen(
        mockForexBloc,
        Stream.fromIterable([state]),
        initialState: state,
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.text('No symbols found'), findsOneWidget);
    });

    testWidgets('shows list of symbols when available', (tester) async {
      final symbols = [
        ExchangeSymbol(symbol: 'EURUSD', description: '', displaySymbol: ''),
        ExchangeSymbol(symbol: 'GBPUSD', description: '', displaySymbol: ''),
      ];

      final state = ExchangeSymbolsState.initial().copyWith(
        exchanges: ['FOREX'],
        selectedExchange: 'FOREX',
        symbols: symbols,
        isLoading: false,
        isSymbolsLoading: false,
      );

      whenListen(
        mockForexBloc,
        Stream.fromIterable([state]),
        initialState: state,
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.byType(ExchangeSymbolWidget), findsNWidgets(2));
    });
  });
}
