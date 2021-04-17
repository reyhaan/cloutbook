import 'package:cloutbook/assets.dart';
import 'package:cloutbook/config/palette.dart';
import 'package:cloutbook/models/PostModel.dart';
import 'package:cloutbook/widgets/ProfileHeader.dart';
import 'package:cloutbook/widgets/ProfileMetadata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'dart:convert';

class Posts extends StatefulWidget {
  final bool? isProfile;
  final List<Post>? posts;

  Posts({
    Key? key,
    this.isProfile,
    this.posts,
  }) : super(key: key);

  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  void initState() {
    super.initState();
    print(widget.posts);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: widget.posts?.length ?? 3,
        itemBuilder: (context, index) {
          if (widget.isProfile == true) {
            if (index == 0) {
              return ProfileHeader();
            }
            if (index == 1) {
              return ProfileMetadata();
            }
          }
          if (widget.posts == null) {
            return Center(
              child: Text(
                'Nothing to show here',
                style: TextStyle(color: Palette.hintColor),
              ),
            );
          }
          return PostItem(post: widget.posts?[index]);
        },
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
    // final postTime = Jiffy(post?.timestampNanos.toString()).format();
    // final timeElapsed = Jiffy(postTime).hour;

    var imageUrl = '';

    if (post?.imageUrls != null) {
      var l = post?.imageUrls?.length;

      if (l! > 0) {
        imageUrl = post?.imageUrls?[0];
      }
    }

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
            height: 42,
            width: 42,
            margin: EdgeInsets.fromLTRB(16.0, 10.0, 20.0, 8.0),
            decoration: BoxDecoration(
              color: Colors.grey,
              image: DecorationImage(
                image: AssetImage(Assets.avatar),
              ),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    'some name',
                    style: TextStyle(
                        color: Palette.primary4, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Text(
                    post?.body ?? '',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white70),
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
                  padding: const EdgeInsets.only(left: 0, right: 16),
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
                      Text.rich(
                        TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                CupertinoIcons.link,
                                size: 18.0,
                              ),
                            ),
                            TextSpan(text: '  ${1}h'),
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
