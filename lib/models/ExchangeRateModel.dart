import 'package:equatable/equatable.dart';

class ExchangeRate extends Equatable {
  final double? nanosSold;
  final double? satoshisPerBitCloutExchangeRate;
  final double? usdCentsPerBitcoinExchangeRate;

  ExchangeRate({
    this.nanosSold,
    this.satoshisPerBitCloutExchangeRate,
    this.usdCentsPerBitcoinExchangeRate,
  });

  List<dynamic> get props => [
        nanosSold,
        satoshisPerBitCloutExchangeRate,
        usdCentsPerBitcoinExchangeRate,
      ];

  factory ExchangeRate.fromMap(Map<String, dynamic> map) {
    return ExchangeRate(
      nanosSold: map['NanosSold'],
      satoshisPerBitCloutExchangeRate: map['SatoshisPerBitCloutExchangeRate'],
      usdCentsPerBitcoinExchangeRate: map['USDCentsPerBitcoinExchangeRate'],
    );
  }
}
