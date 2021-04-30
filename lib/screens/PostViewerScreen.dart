import 'package:cloutbook/models/PostModel.dart';
import 'package:cloutbook/stores/ProfileStore.dart';
import 'package:cloutbook/widgets/Replies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class PostViewerScreen extends HookWidget {
  final ProfileStore _profileStore = GetIt.I<ProfileStore>();
  final Post? post;

  PostViewerScreen({
    Key? key,
    this.post,
  }) : super(key: key);

  void getReplies() async {
    await _profileStore.getSinglePost(postHash: post?.postHashHex);
  }

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      getReplies();
    }, []);

    List<Post> replies = [];

    return Scaffold(
      body: SafeArea(
        child: Observer(
          builder: (_) {
            if (_profileStore.postOpenedByUser.comments != null) {
              if (_profileStore.postOpenedByUser.comments!.length > 0) {
                replies = _profileStore.postOpenedByUser.comments!;
              }
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
