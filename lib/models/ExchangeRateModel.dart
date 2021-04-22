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
      nanosSold: double.parse(map['NanosSold'].toString()),
      satoshisPerBitCloutExchangeRate:
          double.parse(map['SatoshisPerBitCloutExchangeRate'].toString()),
      usdCentsPerBitcoinExchangeRate:
          double.parse(map['USDCentsPerBitcoinExchangeRate'].toString()),
    );
  }
}
