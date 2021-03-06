import 'package:cloutbook/models/PostModel.dart';
import 'package:cloutbook/stores/GlobalFeedStore.dart';
import 'package:cloutbook/stores/ProfileStore.dart';
import 'package:cloutbook/widgets/Replies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class PostViewerScreen extends HookWidget {
  final ProfileStore _profileStore = GetIt.I<ProfileStore>();
  final GlobalFeedStore _globalFeedStore = GetIt.I<GlobalFeedStore>();
  final Post? post;
  final bool isProfilePost;

  PostViewerScreen({
    Key? key,
    this.post,
    this.isProfilePost = false,
  }) : super(key: key);

  void getReplies() async {
    await _profileStore.getSinglePost(
        postHash: post?.postHashHex, isProfilePost: isProfilePost);
  }

  @override
  Widget build(BuildContext context) {
    bool isReclouted = false;

    useEffect(() {
      // check if the post is a reclouted post
      if (post?.recloutedPostEntryResponse != null) {
        isReclouted = true;
      }
      getReplies();
    }, []);

    List<Post> replies = [];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Comments',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: SafeArea(
        child: Observer(
          builder: (_) {
            _globalFeedStore.globalFeed;
            final _post = _profileStore.getPostByHash(
              postHash: post?.postHashHex,
              isProfile: isProfilePost,
              isReclouted: isReclouted,
            );

            if (_post != null) {
              replies = _post.comments!;
            }

            return Stack(
              children: [
                Positioned(
                  child: Replies(
                    parentPost: post,
                    posts: replies,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
