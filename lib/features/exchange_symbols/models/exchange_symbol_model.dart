class ExchangeSymbol {
  final String description;
  final String displaySymbol;
  final String symbol;

  ExchangeSymbol({
    required this.description,
    required this.displaySymbol,
    required this.symbol,
  });

  factory ExchangeSymbol.fromJson(Map<String, dynamic> json) {
    return ExchangeSymbol(
      description: json['description'] as String,
      displaySymbol: json['displaySymbol'] as String,
      symbol: json['symbol'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'description': description,
        'displaySymbol': displaySymbol,
        'symbol': symbol,
      };
}
