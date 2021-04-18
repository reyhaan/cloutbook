import 'package:equatable/equatable.dart';

class USD extends Equatable {
  final double? current;

  USD({
    this.current,
  });

  List<dynamic> get props => [
        current,
      ];

  factory USD.fromMap(Map<String, dynamic> map) {
    return USD(
      current: map['15m'],
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

    currentRate = USD.fromMap(map['USD']);

    return Ticker(
      usd: currentRate,
    );
  }
}
