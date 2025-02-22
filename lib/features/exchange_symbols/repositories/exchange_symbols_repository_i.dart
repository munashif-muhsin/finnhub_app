import 'package:dio/dio.dart';

import '../../../utils/api_url.dart';
import '../../../utils/dio_instance.dart';
import '../../common/models/exchange_symbol_model.dart';
import 'exchange_symbols_repository.dart';

class ExchangeSymbolsRepositoryImplementation implements ExchangeSymbolsRepository {
  final ApiUrls apiUrls;

  ExchangeSymbolsRepositoryImplementation(this.apiUrls);

  @override
  Future<List<String>> getExchanges() async {
    final Response response = await DioInstance.instance.dio.get(
      apiUrls.forexExchanges,
    );

    final responseData = response.data;
    return List<String>.from(responseData);
  }

  @override
  Future<List<ExchangeSymbol>> getSymbols(String exchange) async {
    final Response response = await DioInstance.instance.dio.get(
      apiUrls.forexSymbols(exchange),
    );

    final responseData = response.data;

    return List<ExchangeSymbol>.from((responseData as List).map(
      (symbol) => ExchangeSymbol.fromJson(symbol),
    ));
  }
}
