import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiUrls {
  final String restUrl;
  final String wsUrl;

  ApiUrls({required this.restUrl, required this.wsUrl});

  /// Creates ApiUrls instance from environment variables
  ///
  /// [env] The DotEnv instance containing environment variables
  factory ApiUrls.fromEnv(DotEnv env) {
    return ApiUrls(
      restUrl: env.get('REST_URL', fallback: ''),
      wsUrl: env.get('WS_URL', fallback: ''),
    );
  }

  /// Generates URL for fetching symbols from an exchange
  /// [API Docs](https://finnhub.io/docs/api/forex-symbols)
  /// [API Docs](https://finnhub.io/docs/api/crypto-symbols)
  ///
  /// [exchange] The exchange identifier
  /// [exchangeType] The type of exchange (forex/crypto)
  String symbols(String exchange, String exchangeType) => '$restUrl/v1/$exchangeType/symbol?exchange=$exchange';

  /// Generates URL for fetching available exchanges
  /// [API Docs](https://finnhub.io/docs/api/forex-exchanges)
  /// [API Docs](https://finnhub.io/docs/api/crypto-exchanges)
  ///
  /// [exchangeType] The type of exchange (forex/crypto)
  String exchanges(String exchangeType) => '$restUrl/v1/$exchangeType/exchange';
}
