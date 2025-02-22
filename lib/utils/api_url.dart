import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiUrls {
  final String restUrl;
  final String wsUrl;

  ApiUrls({required this.restUrl, required this.wsUrl});

  /// We can setup Urls here based on the endpoint.
  factory ApiUrls.fromEnv(DotEnv env) {
    return ApiUrls(
      restUrl: env.get('REST_URL', fallback: ''),
      wsUrl: env.get('WS_URL', fallback: ''),
    );
  }

  /// Get a list of Forex/Crypto symbols
  /// [API Docs](https://finnhub.io/docs/api/forex-symbols)
  /// [API Docs](https://finnhub.io/docs/api/crypto-symbols)
  String symbols(String exchange, String exchangeType) => '$restUrl/v1/$exchangeType/symbol?exchange=$exchange';

  /// Get a list of Forex/Crypto Exchanges
  /// [API Docs](https://finnhub.io/docs/api/forex-exchanges)
  /// [API Docs](https://finnhub.io/docs/api/crypto-exchanges)
  String exchanges(String exchangeType) => '$restUrl/v1/$exchangeType/exchange';
}
