import 'package:dio/dio.dart';

import '../../../utils/api_url.dart';
import '../../../utils/dio_instance.dart';
import '../models/forex_symbol_model.dart';
import 'forex_repository.dart';

class ForexRepositoryImplementation implements ForexRepository {
  final ApiUrls apiUrls;

  ForexRepositoryImplementation(this.apiUrls);

  @override
  Future<List<String>> getExchanges() async {
    final Response response = await DioInstance.instance.dio.get(
      apiUrls.exchanges,
    );

    final responseData = response.data;
    return List<String>.from(responseData);
  }

  @override
  Future<List<ForexSymbol>> getSymbols(String exchange) async {
    final Response response = await DioInstance.instance.dio.get(
      apiUrls.symbols(exchange),
    );

    final responseData = response.data;

    return List<ForexSymbol>.from((responseData as List).map(
      (symbol) => ForexSymbol.fromJson(symbol),
    ));
  }
}
