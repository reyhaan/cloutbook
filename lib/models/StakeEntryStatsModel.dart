import 'package:equatable/equatable.dart';

class StakeEntryStats extends Equatable {
  final int? totalCreatorEarningsNanos;
  final int? totalFeesBurnedNanos;
  final int? totalPostStakeNanos;
  final int? totalStakeNanos;
  final int? totalStakeOwnedNanos;

  StakeEntryStats({
    this.totalCreatorEarningsNanos,
    this.totalFeesBurnedNanos,
    this.totalPostStakeNanos,
    this.totalStakeNanos,
    this.totalStakeOwnedNanos,
  });

  List<dynamic> get props => [
        totalCreatorEarningsNanos,
        totalFeesBurnedNanos,
        totalPostStakeNanos,
        totalStakeNanos,
        totalStakeOwnedNanos,
      ];

  factory StakeEntryStats.fromMap(Map<String, dynamic> map) {
    return StakeEntryStats(
      totalCreatorEarningsNanos: map['TotalCreatorEarningsNanos'],
      totalFeesBurnedNanos: map['TotalFeesBurnedNanos'],
      totalPostStakeNanos: map['TotalPostStakeNanos'],
      totalStakeNanos: map['TotalStakeNanos'],
      totalStakeOwnedNanos: map['TotalStakeOwnedNanos'],
    );
  }

  Map<String, dynamic> toJson() => {
        "TotalCreatorEarningsNanos": this.totalCreatorEarningsNanos,
        "TotalFeesBurnedNanos": this.totalFeesBurnedNanos,
        "TotalPostStakeNanos": this.totalPostStakeNanos,
        "TotalStakeNanos": this.totalStakeNanos,
        "TotalStakeOwnedNanos": this.totalStakeOwnedNanos,
      };
}
