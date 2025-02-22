import '../models/forex_symbol_model.dart';

abstract class ForexRepository {
  /// Get the list of Forex Exchanges
  Future<List<String>> getExchanges();

  /// Get the list of Forex Symbols
  Future<List<ForexSymbol>> getSymbols(String exchange);
}
