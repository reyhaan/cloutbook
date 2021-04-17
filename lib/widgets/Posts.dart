import 'package:cloutbook/config/palette.dart';
import 'package:cloutbook/models/PostModel.dart';
import 'package:cloutbook/stores/GlobalFeedStore.dart';
import 'package:cloutbook/widgets/ProfileHeader.dart';
import 'package:cloutbook/widgets/ProfileMetadata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:jiffy/jiffy.dart';
import 'dart:convert';

class Posts extends HookWidget {
  final GlobalFeedStore _globalFeedStore = GetIt.I<GlobalFeedStore>();
  final List<Post> posts;
  final bool isProfile;

  Posts({
    Key? key,
    this.posts = const [],
    this.isProfile = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int postsLength = posts.length;
    if (posts.length == 0) {
      postsLength = 3;
    }

    return Container(
      child: RefreshIndicator(
        onRefresh: () {
          _globalFeedStore.getGlobalFeed();
          return Future.delayed(Duration(seconds: 0));
        },
        child: ListView.builder(
          itemCount: postsLength,
          itemBuilder: (context, index) {
            // Profile section
            if (isProfile == true) {
              if (index == 0) {
                return ProfileHeader();
              }
              if (index == 1) {
                return ProfileMetadata();
              }
            }
            if (posts.length == 0) {
              if (index == 2) {
                return Center(
                  child: Text(
                    'Nothing to show here',
                    style: TextStyle(color: Palette.hintColor),
                  ),
                );
              }
              return Text('');
            }
            // Profile section ends

            // Add load more button here
            if (index == posts.length - 1) {
              return Column(
                children: [
                  PostItem(post: posts[index]),
                  GestureDetector(
                    onTap: Feedback.wrapForTap(() {
                      // call global feed again
                      _globalFeedStore.getGlobalFeed();
                    }, context),
                    child: Container(
                      height: 50,
                      width: 200,
                      margin: EdgeInsets.only(bottom: 20),
                      color: Palette.background,
                      child: Center(
                          child: Text(
                        'Load more',
                        style: TextStyle(color: Palette.primary4, fontSize: 14),
                      )),
                    ),
                  ),
                ],
              );
            }

            return PostItem(post: posts[index]);
          },
        ),
      ),
    );
  }
}

class PostItem extends StatelessWidget {
  final Post? post;

  const PostItem({
    Key? key,
    this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stripped = post?.profileEntryResponse?.profilePic
        ?.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '') as String;

    final avatar = base64.decode(stripped);

    var imageUrl = '';

    if (post?.imageUrls != null) {
      var l = post?.imageUrls?.length;

      if (l! > 0) {
        imageUrl = post?.imageUrls?[0];
      }
    }

    final int given = post?.timestampNanos as int;
    final diff = (given / 1000000000).floor();
    final utc = Jiffy.unix(diff).utc();
    final fromNow = Jiffy(utc).fromNow();
    final timeElapsed = fromNow;

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.only(bottom: 22, top: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1.0,
            color: Palette.foreground,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 48,
            width: 48,
            margin: EdgeInsets.fromLTRB(12.0, 0.0, 14.0, 8.0),
            decoration: BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(21),
              child: Image.memory(avatar),
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    '@${post?.profileEntryResponse?.username}',
                    style: TextStyle(
                      color: Palette.primary4,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 4, bottom: 6),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: '$timeElapsed',
                            style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Text(
                    post?.body ?? '',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.white, fontSize: 15, height: 1.2),
                  ),
                ),
                Visibility(
                  visible: post?.body != '',
                  child: SizedBox(height: 16),
                ),
                Visibility(
                  visible: imageUrl != '',
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 200),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            image: DecorationImage(
                              image: NetworkImage(
                                imageUrl,
                              ),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: imageUrl != '',
                  child: SizedBox(height: 20),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                CupertinoIcons.bubble_left,
                                size: 18.0,
                              ),
                            ),
                            TextSpan(text: '  ${post?.commentCount}'),
                          ],
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                CupertinoIcons.arrow_2_squarepath,
                                size: 18.0,
                              ),
                            ),
                            TextSpan(text: '  ${post?.recloutCount}'),
                          ],
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                CupertinoIcons.heart,
                                size: 18.0,
                              ),
                            ),
                            TextSpan(text: '  ${post?.likeCount}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
