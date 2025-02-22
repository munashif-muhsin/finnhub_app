part of 'exchange_symbols_bloc.dart';

abstract class ExchangeSymbolsEvent {}

class InitializeExchangeSymbolsState extends ExchangeSymbolsEvent {}

class ChangeExchange extends ExchangeSymbolsEvent {
  final String exchange;

  ChangeExchange(this.exchange);
}
