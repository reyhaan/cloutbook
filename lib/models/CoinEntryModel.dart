import 'package:equatable/equatable.dart';

class CoinEntry extends Equatable {
  final int? bitCloutLockedNanos;
  final int? coinWatermarkNanos;
  final int? coinsInCirculationNanos;
  final int? creatorBasisPoints;
  final int? numberOfHolders;

  CoinEntry({
    this.bitCloutLockedNanos,
    this.coinWatermarkNanos,
    this.coinsInCirculationNanos,
    this.creatorBasisPoints,
    this.numberOfHolders,
  });

  List<Object> get props => [
        bitCloutLockedNanos!,
        coinWatermarkNanos!,
        coinsInCirculationNanos!,
        creatorBasisPoints!,
        numberOfHolders!,
      ];

  factory CoinEntry.fromMap(Map<String, dynamic> map) {
    return CoinEntry(
      bitCloutLockedNanos: map['BitCloutLockedNanos'],
      coinWatermarkNanos: map['CoinWatermarkNanos'],
      coinsInCirculationNanos: map['CoinsInCirculationNanos'],
      creatorBasisPoints: map['CreatorBasisPoints'],
      numberOfHolders: map['NumberOfHolders'],
    );
  }

  Map<String, dynamic> toJson() => {
        "BitCloutLockedNanos": this.bitCloutLockedNanos,
        "CoinWatermarkNanos": this.coinWatermarkNanos,
        "CoinsInCirculationNanos": this.coinsInCirculationNanos,
        "CreatorBasisPoints": this.creatorBasisPoints,
        "NumberOfHolders": this.numberOfHolders,
      };
}
