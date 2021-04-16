import 'package:cloutbook/models/ProfileModel.dart';
import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final String body;
  final int? commentCount;
  final List<Post>? comments;
  final List<String>? imageUrls;
  final bool? isHidden;
  final bool? isPinned;
  final int? likeCount;
  final List<Post>? parentPosts;
  final String? parentStakeId;
  final Map<String, dynamic>? postEntryReaderState;
  final String postHashHex;
  final String? posterPublicKeyBase58Check;
  final ProfileEntryResponse? profileEntryResponse;
  final int? recloutCount;
  final int? stakeMultipleBasisPoints;
  final int? timestampNanos;

  Post({
    this.body = '',
    this.commentCount,
    this.comments,
    this.imageUrls,
    this.isHidden,
    this.isPinned,
    this.likeCount,
    this.parentPosts,
    this.parentStakeId,
    this.postEntryReaderState,
    this.postHashHex = '',
    this.posterPublicKeyBase58Check,
    this.profileEntryResponse,
    this.recloutCount,
    this.stakeMultipleBasisPoints,
    this.timestampNanos,
  });

  List<Object> get props => [
        body,
        commentCount!,
        comments!,
        imageUrls!,
        isHidden!,
        isPinned!,
        likeCount!,
        parentPosts!,
        parentStakeId!,
        postEntryReaderState!,
        postHashHex,
        posterPublicKeyBase58Check!,
        profileEntryResponse!,
        recloutCount!,
        stakeMultipleBasisPoints!,
        timestampNanos!,
      ];

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      body: map['Body'],
      commentCount: map['CommentCount'],
      comments: map['Comments'],
      imageUrls: map['ImageURLs'],
      isHidden: map['IsHidden'],
      isPinned: map['IsPinned'],
      likeCount: map['LikeCount'],
      parentPosts: map['ParentPosts'],
      parentStakeId: map['ParentStakeID'],
      postEntryReaderState: map['PostEntryReaderState'],
      postHashHex: map['PostHashHex'],
      posterPublicKeyBase58Check: map['PosterPublicKeyBase58Check'],
      profileEntryResponse: map['ProfileEntryResponse'],
      recloutCount: map['RecloutCount'],
      stakeMultipleBasisPoints: map['StakeMultipleBasisPoints'],
      timestampNanos: map['TimestampNanos'],
    );
  }
}
