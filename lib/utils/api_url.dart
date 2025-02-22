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

  /// Get a list of Forex symbols
  /// [API Docs](https://finnhub.io/docs/api/forex-symbols)
  String symbols(String exchange) => '$restUrl/v1/forex/symbol?exchange=$exchange';

  /// Get a list of Forex Exchanges
  /// [API Docs](https://finnhub.io/docs/api/forex-exchanges)
  String get exchanges => '$restUrl/v1/forex/exchange';
}
