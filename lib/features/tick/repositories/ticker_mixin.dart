import '../models/tick_model.dart';
import 'api_connection.dart';

mixin TickerMixin {
  void subscribeToSymbol(String symbol) {
    return ApiConnection.instance.subscribeToSymbol(symbol);
  }

  void unsubscribeToSymbol(String symbol) {
    return ApiConnection.instance.unsubscribeFromSymbol(symbol);
  }

  Stream<TickData> tickStream(String symbol) =>
      ApiConnection.instance.tickStream.where((event) => event.symbol == symbol);
}
