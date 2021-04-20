import 'package:cloutbook/models/CoinEntryModel.dart';
import 'package:cloutbook/models/PostModel.dart';
import 'package:equatable/equatable.dart';

class ProfileEntryResponse extends Equatable {
  final CoinEntry? coinEntry;
  final int? coinPriceBitCloutNanos;
  final List<dynamic>? comments;
  final String? description;
  final bool? isHidden;
  final bool? isReserved;
  final bool? isVerified;
  final List<Post> posts;
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
    required this.posts,
    this.profilePic,
    this.publicKeyBase58Check,
    this.stakeEntryStats,
    this.stakeMultipleBasisPoints,
    this.username,
    this.usersThatHODL,
  });

  List<dynamic> get props => [
        coinEntry,
        coinPriceBitCloutNanos,
        comments,
        description,
        isHidden,
        isReserved,
        isVerified,
        posts,
        profilePic,
        publicKeyBase58Check,
        stakeEntryStats,
        stakeMultipleBasisPoints,
        username,
        usersThatHODL,
      ];

  factory ProfileEntryResponse.fromMap(Map<String, dynamic> map) {
    CoinEntry coinEntry = CoinEntry.fromMap({});
    List<Post> posts = [];

    if (map['CoinEntry'] != null) {
      coinEntry =
          CoinEntry.fromMap(Map<String, dynamic>.from(map['CoinEntry']));
    }

    if (map['Posts'] != null) {
      List<dynamic> allPosts = map['Posts'];
      allPosts.forEach((post) {
        posts.add(Post.fromMap(post));
      });
    }

    return ProfileEntryResponse(
      coinEntry: coinEntry,
      coinPriceBitCloutNanos: map['CoinPriceBitCloutNanos'],
      comments: map['Comments'],
      description: map['Description'],
      isHidden: map['IsHidden'],
      isReserved: map['IsReserved'],
      isVerified: map['IsVerified'],
      posts: posts,
      profilePic: map['ProfilePic'],
      publicKeyBase58Check: map['PublicKeyBase58Check'],
      stakeEntryStats: map['StakeEntryStats'],
      stakeMultipleBasisPoints: map['StakeMultipleBasisPoints'],
      username: map['Username'],
      usersThatHODL: map['UsersThatHODL'],
    );
  }

  Map<String, dynamic> toJson() {
    final posts = [];
    this.posts.forEach((post) {
      posts.add(post);
    });
    return {
      "CoinEntry": this.coinEntry?.toJson(),
      "CoinPriceBitCloutNanos": this.coinPriceBitCloutNanos,
      "Comments": this.comments,
      "Description": this.description,
      "IsHidden": this.isHidden,
      "IsReserved": this.isReserved,
      "IsVerified": this.isVerified,
      "Posts": posts,
      "ProfilePic": this.profilePic,
      "PublicKeyBase58Check": this.publicKeyBase58Check,
      "StakeEntryStats": this.stakeEntryStats,
      "StakeMultipleBasisPoints": this.stakeMultipleBasisPoints,
      "Username": this.username,
      "UsersThatHODL": this.usersThatHODL,
    };
  }
}
