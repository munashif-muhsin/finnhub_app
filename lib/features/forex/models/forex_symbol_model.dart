class ForexSymbol {
  final String description;
  final String displaySymbol;
  final String symbol;

  ForexSymbol({
    required this.description,
    required this.displaySymbol,
    required this.symbol,
  });

  factory ForexSymbol.fromJson(Map<String, dynamic> json) {
    return ForexSymbol(
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
