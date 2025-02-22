import 'package:bloc_test/bloc_test.dart';
import 'package:finnhub_app/features/common/widgets/error_retry_widget.dart';
import 'package:finnhub_app/features/forex/models/forex_symbol_model.dart';
import 'package:finnhub_app/features/forex/presentation/components/forex_symbol_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finnhub_app/features/forex/bloc/forex_bloc.dart';
import 'package:finnhub_app/features/forex/presentation/forex_page.dart';

class MockForexBloc extends MockBloc<ForexEvent, ForexState> implements ForexBloc {}

void main() {
  late MockForexBloc mockForexBloc;

  setUp(() {
    mockForexBloc = MockForexBloc();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<ForexBloc>.value(
        value: mockForexBloc,
        child: const ForexPage(),
      ),
    );
  }

  group('ForexPage', () {
    testWidgets('shows loading indicator when state is loading', (tester) async {
      whenListen(
        mockForexBloc,
        Stream.fromIterable([ForexState.initial()]),
        initialState: ForexState.initial(),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows error widget when state has error', (tester) async {
      whenListen(
        mockForexBloc,
        Stream.fromIterable([ForexState.initial().copyWith(hasError: true, isLoading: false)]),
        initialState: ForexState.initial(),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.byType(ErrorRetryWidget), findsOneWidget);
    });

    testWidgets('shows empty message when no symbols available', (tester) async {
      final state = ForexState.initial().copyWith(
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
        ForexSymbol(symbol: 'EURUSD', description: '', displaySymbol: ''),
        ForexSymbol(symbol: 'GBPUSD', description: '', displaySymbol: ''),
      ];

      final state = ForexState.initial().copyWith(
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

      expect(find.byType(ForexSymbolWidget), findsNWidgets(2));
    });
  });
}
