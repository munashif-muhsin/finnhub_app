part of 'exchange_symbols_bloc.dart';

class ExchangeSymbolsState {
  final bool isLoading;
  final bool isSymbolsLoading;
  final List<ExchangeSymbol> symbols;
  final List<String> exchanges;
  final String? selectedExchange;
  final bool hasError;

  factory ExchangeSymbolsState.initial() {
    return ExchangeSymbolsState(
      isLoading: true,
      symbols: [],
      exchanges: [],
      isSymbolsLoading: true,
      hasError: false,
    );
  }

  ExchangeSymbolsState({
    required this.isLoading,
    required this.isSymbolsLoading,
    required this.symbols,
    required this.exchanges,
    this.selectedExchange,
    required this.hasError,
  });

  ExchangeSymbolsState copyWith({
    bool? isLoading,
    bool? isSymbolsLoading,
    List<ExchangeSymbol>? symbols,
    List<String>? exchanges,
    String? selectedExchange,
    bool? hasError,
  }) {
    return ExchangeSymbolsState(
      isLoading: isLoading ?? this.isLoading,
      isSymbolsLoading: isSymbolsLoading ?? this.isSymbolsLoading,
      symbols: symbols ?? this.symbols,
      exchanges: exchanges ?? this.exchanges,
      selectedExchange: selectedExchange ?? this.selectedExchange,
      hasError: hasError ?? this.hasError,
    );
  }
}
