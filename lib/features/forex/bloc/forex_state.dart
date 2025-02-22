part of 'forex_bloc.dart';

class ForexState {
  final bool isLoading;
  final bool isSymbolsLoading;
  final List<ForexSymbol> symbols;
  final List<String> exchanges;
  final String? selectedExchange;
  final bool hasError;

  factory ForexState.initial() {
    return ForexState(
      isLoading: true,
      symbols: [],
      exchanges: [],
      isSymbolsLoading: true,
      hasError: false,
    );
  }

  ForexState({
    required this.isLoading,
    required this.isSymbolsLoading,
    required this.symbols,
    required this.exchanges,
    this.selectedExchange,
    required this.hasError,
  });

  ForexState copyWith({
    bool? isLoading,
    bool? isSymbolsLoading,
    List<ForexSymbol>? symbols,
    List<String>? exchanges,
    String? selectedExchange,
    bool? hasError,
  }) {
    return ForexState(
      isLoading: isLoading ?? this.isLoading,
      isSymbolsLoading: isSymbolsLoading ?? this.isSymbolsLoading,
      symbols: symbols ?? this.symbols,
      exchanges: exchanges ?? this.exchanges,
      selectedExchange: selectedExchange ?? this.selectedExchange,
      hasError: hasError ?? this.hasError,
    );
  }
}
