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
        stakeMultipleBasisPoints,
        timestampNanos,
      ];

  factory Post.fromMap(Map<String, dynamic> map) {
    ProfileEntryResponse profileEntryResponse;

    if (map['ProfileEntryResponse'] != null) {}
    profileEntryResponse =
        ProfileEntryResponse.fromMap(map['ProfileEntryResponse']);

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
      stakeMultipleBasisPoints: map['StakeMultipleBasisPoints'] ?? 0,
      timestampNanos: map['TimestampNanos'],
    );
  }
}
