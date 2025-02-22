import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'dart:async';

import 'package:finnhub_app/features/tick/presentation/tick_widget.dart';
import 'package:finnhub_app/features/tick/models/tick_model.dart';
import 'package:finnhub_app/features/tick/utils/ticker_mixin.dart';

abstract class MockFunctionWithAParam {
  void call(String message);
}

class MockOnSubscribeToSymbol extends Mock implements MockFunctionWithAParam {}

class MockOnUnsubscribeToSymbol extends Mock implements MockFunctionWithAParam {}

final mockOnSubscribe = MockOnSubscribeToSymbol();
final mockOnUnsubscribe = MockOnUnsubscribeToSymbol();

mixin MockTickerMixin on TickerMixin {
  final _streamController = StreamController<TickData>();
  late final Stream<TickData> _broadcastStream = _streamController.stream.asBroadcastStream();

  StreamController<TickData> get streamController => _streamController;

  @override
  void subscribeToSymbol(String symbol) {
    mockOnSubscribe.call(symbol);
  }

  @override
  void unsubscribeToSymbol(String symbol) {
    mockOnUnsubscribe.call(symbol);
  }

  @override
  Stream<TickData> tickStream(String symbol) {
    return _broadcastStream;
  }
}

class MockTickWidgetWithMixin extends TickWidget with MockTickerMixin {
  MockTickWidgetWithMixin({super.key, required super.symbol, super.showIcon});
}

void main() {
  setUp(() {
    reset(mockOnSubscribe);
    reset(mockOnUnsubscribe);
  });

  Widget createWidget({bool showIcon = true}) {
    return MaterialApp(
      home: Scaffold(
        body: MockTickWidgetWithMixin(
          symbol: 'AAPL',
          showIcon: showIcon,
        ),
      ),
    );
  }

  testWidgets('TickWidget displays initial dash when no data', (WidgetTester tester) async {
    await tester.pumpWidget(createWidget());
    expect(find.text('--'), findsOneWidget);
    verify(() => mockOnSubscribe.call('AAPL')).called(1);
  });

  testWidgets('TickWidget shows price and changes color on price update', (WidgetTester tester) async {
    await tester.pumpWidget(createWidget());
    final widget = tester.widget<MockTickWidgetWithMixin>(find.byType(MockTickWidgetWithMixin));

    widget.streamController.add(TickData(symbol: 'AAPL', price: 150.0));
    await tester.pump(Duration.zero);
    expect(find.text('150.00'), findsOneWidget);

    expect((tester.widget(find.byType(Text).first) as Text).style?.color, equals(Colors.grey));

    widget.streamController.add(TickData(symbol: 'AAPL', price: 151.0));
    await tester.pump(Duration.zero);
    expect(find.text('151.00'), findsOneWidget);
    expect((tester.widget(find.byType(Text).first) as Text).style?.color, equals(Colors.green));

    widget.streamController.add(TickData(symbol: 'AAPL', price: 149.0));
    await tester.pump(Duration.zero);
    expect(find.text('149.00'), findsOneWidget);
    expect((tester.widget(find.byType(Text).first) as Text).style?.color, equals(Colors.red));
  });

  testWidgets('TickWidget shows/hides directional icon based on showIcon property', (WidgetTester tester) async {
    await tester.pumpWidget(createWidget(showIcon: false));
    expect(find.byType(Icon), findsNothing);

    await tester.pumpWidget(createWidget(showIcon: true));
    await tester.pump();
    expect(find.byType(Icon), findsOneWidget);
  });

  testWidgets('TickWidget properly subscribes and unsubscribes', (WidgetTester tester) async {
    await tester.pumpWidget(createWidget());
    verify(() => mockOnSubscribe.call('AAPL')).called(1);

    await tester.pumpWidget(const SizedBox());
    verify(() => mockOnUnsubscribe.call('AAPL')).called(1);
  });

  testWidgets('TickWidget shows correct directional icon on price changes', (WidgetTester tester) async {
    await tester.pumpWidget(createWidget());

    final widget = tester.widget<MockTickWidgetWithMixin>(find.byType(MockTickWidgetWithMixin));

    // Initial state
    expect(find.byIcon(Icons.minimize_outlined), findsOneWidget);

    // Price increase
    widget.streamController.add(TickData(symbol: 'AAPL', price: 150.0));
    await tester.pump(Duration.zero);
    widget.streamController.add(TickData(symbol: 'AAPL', price: 151.0));
    await tester.pump(Duration.zero);
    expect(find.byIcon(Icons.keyboard_arrow_up), findsOneWidget);

    // Price decrease
    widget.streamController.add(TickData(symbol: 'AAPL', price: 149.0));
    await tester.pump(Duration.zero);
    expect(find.byIcon(Icons.keyboard_arrow_down), findsOneWidget);
  });
}
