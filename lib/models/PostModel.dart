import 'package:cloutbook/models/ProfileModel.dart';
import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final String? body;
  final int? commentCount;
  final List<dynamic>? comments;
  final List<dynamic>? imageUrls;
  final bool? isHidden;
  final bool? isPinned;
  final int? likeCount;
  final List<dynamic>? parentPosts;
  final String? parentStakeId;
  final Map<String, dynamic>? postEntryReaderState;
  final String? postHashHex;
  final String? posterPublicKeyBase58Check;
  final ProfileEntryResponse? profileEntryResponse;
  final int? recloutCount;
  final Post? recloutedPostEntryResponse;
  final int? stakeMultipleBasisPoints;
  final int timestampNanos;

  Post({
    this.body,
    this.commentCount,
    this.comments,
    this.imageUrls,
    this.isHidden,
    this.isPinned,
    this.likeCount,
    this.parentPosts,
    this.parentStakeId,
    this.postEntryReaderState,
    this.postHashHex,
    this.posterPublicKeyBase58Check,
    this.profileEntryResponse,
    this.recloutCount,
    this.recloutedPostEntryResponse,
    this.stakeMultipleBasisPoints,
    required this.timestampNanos,
  });

  List<dynamic> get props => [
        body,
        commentCount,
        comments,
        imageUrls,
        isHidden,
        isPinned,
        likeCount,
        parentPosts,
        parentStakeId,
        postEntryReaderState,
        postHashHex,
        posterPublicKeyBase58Check,
        profileEntryResponse,
        recloutCount,
        recloutedPostEntryResponse,
        stakeMultipleBasisPoints,
        timestampNanos,
      ];

  factory Post.fromMap(Map<String, dynamic> map) {
    ProfileEntryResponse? profileEntryResponse;
    Post? recloutedPostEntryResponse;

    if (map['ProfileEntryResponse'] != null) {
      profileEntryResponse = ProfileEntryResponse.fromMap(map['ProfileEntryResponse']);
    }

    if (map['RecloutedPostEntryResponse'] != null) {
      recloutedPostEntryResponse = Post.fromMap(map['RecloutedPostEntryResponse']);
    }

    return Post(
      body: map['Body'] ?? '',
      commentCount: map['CommentCount'] ?? 0,
      comments: map['Comments'] ?? [],
      imageUrls: map['ImageURLs'] ?? [],
      isHidden: map['IsHidden'],
      isPinned: map['IsPinned'],
      likeCount: map['LikeCount'] ?? 0,
      parentPosts: map['ParentPosts'] ?? [],
      parentStakeId: map['ParentStakeID'] ?? '',
      postEntryReaderState: map['PostEntryReaderState'] ?? {},
      postHashHex: map['PostHashHex'] ?? '',
      posterPublicKeyBase58Check: map['PosterPublicKeyBase58Check'] ?? '',
      profileEntryResponse: profileEntryResponse,
      recloutCount: map['RecloutCount'] ?? 0,
      recloutedPostEntryResponse: recloutedPostEntryResponse,
      stakeMultipleBasisPoints: map['StakeMultipleBasisPoints'] ?? 0,
      timestampNanos: map['TimestampNanos'],
    );
  }

  Map<String, dynamic> toJson() => {
        "Body": this.body,
        "CommentCount": this.commentCount,
        "Comments": this.comments,
        "ImageUrls": this.imageUrls,
        "IsHidden": this.isHidden,
        "IsPinned": this.isPinned,
        "LikeCount": this.likeCount,
        "ParentPosts": this.parentPosts,
        "ParentStakeId": this.parentStakeId,
        "PostEntryReaderState": this.postEntryReaderState,
        "PostHashHex": this.postHashHex,
        "PosterPublicKeyBase58Check": this.posterPublicKeyBase58Check,
        "ProfileEntryResponse": this.profileEntryResponse,
        "RecloutCount": this.recloutCount,
        "RecloutedPostEntryResponse": this.recloutedPostEntryResponse,
        "StakeMultipleBasisPoints": this.stakeMultipleBasisPoints,
        "TimestampNanos": this.timestampNanos,
      };
}
