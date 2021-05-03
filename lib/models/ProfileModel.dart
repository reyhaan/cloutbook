import 'package:cloutbook/models/CoinEntryModel.dart';
import 'package:cloutbook/models/PostModel.dart';
import 'package:cloutbook/models/StakeEntryStatsModel.dart';
import 'package:equatable/equatable.dart';

class ProfileEntryResponse extends Equatable {
  final CoinEntry? coinEntry;
  final int? coinPriceBitCloutNanos;
  final List<dynamic>? comments;
  final String? description;
  final bool? isHidden;
  final bool? isReserved;
  final bool? isVerified;
  List<Post> posts;
  final String? profilePic;
  final String? publicKeyBase58Check;
  final StakeEntryStats? stakeEntryStats;
  final int? stakeMultipleBasisPoints;
  final String? username;
  final dynamic? usersThatHODL;
  final History? history;
  String? followers = '-';

  set setFollowers(String? _followers) {
    followers = _followers;
  }

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
    this.history,
    this.followers,
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
        history,
        followers,
      ];

  factory ProfileEntryResponse.fromMap(Map<String, dynamic> map) {
    CoinEntry coinEntry = CoinEntry.fromMap({});
    StakeEntryStats stakeEntryStats = StakeEntryStats.fromMap({});
    History history = History.fromMap({});
    List<Post> posts = [];
    List<String> usersThatHODL = [];

    if (map['CoinEntry'] != null) {
      coinEntry =
          CoinEntry.fromMap(Map<String, dynamic>.from(map['CoinEntry']));
    }

    if (map['StakeEntryStats'] != null) {
      stakeEntryStats = StakeEntryStats.fromMap(
          Map<String, dynamic>.from(map['StakeEntryStats']));
    }

    if (map['history'] != null) {
      history = History.fromMap(Map<String, dynamic>.from(map['history']));
    }

    if (map['Posts'] != null) {
      List<dynamic> allPosts = map['Posts'];

      allPosts.forEach((post) {
        posts.add(Post.fromMap(post.cast<String, dynamic>()));
      });
    }

    if (map['UsersThatHODL'] != null) {
      List<dynamic> allHodlers = map['UsersThatHODL'];

      allHodlers.forEach((user) {
        usersThatHODL.add(user);
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
      stakeEntryStats: stakeEntryStats,
      stakeMultipleBasisPoints: map['StakeMultipleBasisPoints'],
      username: map['Username'],
      usersThatHODL: usersThatHODL,
      history: history,
      followers: map['Followers'],
    );
  }

  Map<String, dynamic> toJson() {
    final List<Post> posts = [];
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
      "StakeEntryStats": this.stakeEntryStats?.toJson(),
      "StakeMultipleBasisPoints": this.stakeMultipleBasisPoints,
      "Username": this.username,
      "UsersThatHODL": this.usersThatHODL,
      "history": this.history?.toJson(),
      "followers": this.followers,
    };
  }
}

class History extends Equatable {
  final String? change1h;
  double? change1d;
  final String? change1w;

  History({
    this.change1h,
    this.change1d,
    this.change1w,
  });

  List<dynamic> get props => [
        change1h,
        change1d,
        change1w,
      ];

  factory History.fromMap(Map<String, dynamic> map) {
    return History(
      change1h: map['change1h'],
      change1d: map['change1d'],
      change1w: map['change1w'],
    );
  }

  Map<String, dynamic> toJson() => {
        "change1h": this.change1h,
        "change1d": this.change1d,
        "change1w": this.change1w,
      };
}
