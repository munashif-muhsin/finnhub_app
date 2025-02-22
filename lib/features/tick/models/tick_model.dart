class TickData {
  final double? price;
  final String? symbol;
  final int? time;
  final double? volume;

  TickData({
    this.price,
    this.symbol,
    this.time,
    this.volume,
  });

  factory TickData.fromJson(Map<String, dynamic> map) {
    return TickData(
      price: map['p']?.toDouble(),
      symbol: map['s'],
      time: map['t']?.toInt(),
      volume: map['v']?.toDouble(),
    );
  }

  @override
  String toString() {
    return 'TickData(price: $price, symbol: $symbol, time: $time, volume: $volume)';
  }
}
