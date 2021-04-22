import 'package:equatable/equatable.dart';

class USD extends Equatable {
  final double? current;
  final double? buy;
  final double? last;
  final double? sell;
  final String? symbol;

  USD({
    this.current,
    this.buy,
    this.last,
    this.sell,
    this.symbol,
  });

  List<dynamic> get props => [
        current,
        buy,
        last,
        sell,
        symbol,
      ];

  factory USD.fromMap(Map<String, dynamic> map) {
    return USD(
      current: map['15m'],
      buy: map['buy'],
      last: map['last'],
      sell: map['sell'],
      symbol: map['symbol'],
    );
  }
}

class Ticker extends Equatable {
  final USD? usd;

  Ticker({
    this.usd,
  });

  List<dynamic> get props => [
        usd,
      ];

  factory Ticker.fromMap(Map<String, dynamic> map) {
    USD currentRate;

    currentRate = USD.fromMap(map['USD'].cast<String, dynamic>() ?? {});

    return Ticker(
      usd: currentRate,
    );
  }
}
