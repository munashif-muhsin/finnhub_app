import '../../common/models/exchange_symbol_model.dart';

abstract class ExchangeSymbolsRepository {
  /// Get the list of Forex Exchanges
  Future<List<String>> getExchanges();

  /// Get the list of Forex Symbols
  Future<List<ExchangeSymbol>> getSymbols(String exchange);
}
