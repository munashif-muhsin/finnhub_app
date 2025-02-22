import 'package:dio/dio.dart';

import '../../../utils/api_url.dart';
import '../../../utils/dio_instance.dart';
import '../../common/models/exchange_symbol_model.dart';
import 'exchange_symbols_repository.dart';

class ExchangeSymbolsRepositoryImplementation implements ExchangeSymbolsRepository {
  final ApiUrls apiUrls;

  ExchangeSymbolsRepositoryImplementation(this.apiUrls);

  @override
  Future<List<String>> getExchanges(String exchangeType) async {
    final Response response = await DioInstance.instance.dio.get(
      apiUrls.exchanges(exchangeType),
    );

    final responseData = response.data;
    return List<String>.from(responseData);
  }

  @override
  Future<List<ExchangeSymbol>> getSymbols(String exchange, String exchangeType) async {
    final Response response = await DioInstance.instance.dio.get(
      apiUrls.symbols(exchange, exchangeType),
    );

    final responseData = response.data;

    return List<ExchangeSymbol>.from((responseData as List).map(
      (symbol) => ExchangeSymbol.fromJson(symbol),
    ));
  }
}
