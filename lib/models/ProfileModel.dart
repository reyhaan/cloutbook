import 'package:cloutbook/models/CoinEntryModel.dart';
import 'package:cloutbook/models/PostModel.dart';
import 'package:equatable/equatable.dart';

class ProfileEntryResponse extends Equatable {
  final Map<String, dynamic>? coinEntry;
  final int? coinPriceBitCloutNanos;
  final List<dynamic>? comments;
  final String? description;
  final bool? isHidden;
  final bool? isReserved;
  final bool? isVerified;
  final List<dynamic>? posts;
  final String? profilePic;
  final String? publicKeyBase58Check;
  final Map<String, dynamic>? stakeEntryStats;
  final int? stakeMultipleBasisPoints;
  final String? username;
  final dynamic? usersThatHODL;

  ProfileEntryResponse({
    this.coinEntry,
    this.coinPriceBitCloutNanos,
    this.comments,
    this.description,
    this.isHidden,
    this.isReserved,
    this.isVerified,
    this.posts,
    this.profilePic,
    this.publicKeyBase58Check,
    this.stakeEntryStats,
    this.stakeMultipleBasisPoints,
    this.username,
    this.usersThatHODL,
  });

  List<Object> get props => [
        coinEntry!,
        coinPriceBitCloutNanos!,
        comments!,
        description!,
        isHidden!,
        isReserved!,
        isVerified!,
        posts!,
        profilePic!,
        publicKeyBase58Check!,
        stakeEntryStats!,
        stakeMultipleBasisPoints!,
        username!,
        usersThatHODL!,
      ];

  factory ProfileEntryResponse.fromMap(Map<String, dynamic> map) {
    return ProfileEntryResponse(
      coinEntry: map['CoinEntry'],
      coinPriceBitCloutNanos: map['CoinPriceBitCloutNanos'],
      comments: map['Comments'],
      description: map['Description'],
      isHidden: map['IsHidden'],
      isReserved: map['IsReserved'],
      isVerified: map['IsVerified'],
      posts: map['Posts'],
      profilePic: map['ProfilePic'],
      publicKeyBase58Check: map['PublicKeyBase58Check'],
      stakeEntryStats: map['StakeEntryStats'],
      stakeMultipleBasisPoints: map['StakeMultipleBasisPoints'],
      username: map['Username'],
      usersThatHODL: map['UsersThatHODL'],
    );
  }
}
