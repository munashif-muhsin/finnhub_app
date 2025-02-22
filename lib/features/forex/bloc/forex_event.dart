part of 'forex_bloc.dart';

abstract class ForexEvent {}

class InitializeForexState extends ForexEvent {}

class ChangeExchange extends ForexEvent {
  final String exchange;

  ChangeExchange(this.exchange);
}
