import 'package:auto_route/auto_route.dart';
import 'package:cloutbook/common/utils.dart';
import 'package:cloutbook/config/palette.dart';
import 'package:cloutbook/models/PostModel.dart';
import 'package:cloutbook/routes/router.dart';
import 'package:cloutbook/stores/GlobalFeedStore.dart';
import 'package:cloutbook/widgets/ProfileHeader.dart';
import 'package:cloutbook/widgets/ProfileMetadata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:get_it/get_it.dart';
import 'package:jiffy/jiffy.dart';
import '../stores/ProfileStore.dart';

class Posts extends HookWidget {
  final GlobalFeedStore _globalFeedStore = GetIt.I<GlobalFeedStore>();
  final ProfileStore _profileStore = GetIt.I<ProfileStore>();
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
          _profileStore.getUserProfile(
              username: _profileStore.userProfile.username);
          return Future.delayed(Duration(seconds: 0));
        },
        child: ListView.builder(
          itemCount: postsLength,
          itemBuilder: (context, index) {
            // Profile section
            if (isProfile == true) {
              if (index == 0 && posts.length > 0) {
                return Column(
                  children: [
                    ProfileHeader(),
                    ProfileMetadata(),
                    Visibility(
                      visible: posts.length > 0,
                      child: PostItem(post: posts[index]),
                    ),
                  ],
                );
              } else if (index == 0) {
                return Column(
                  children: [
                    ProfileHeader(),
                    ProfileMetadata(),
                  ],
                );
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
            if (posts.length - 1 > 0 && index == posts.length - 1) {
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

class PostItem extends HookWidget {
  final ProfileStore _profileStore = GetIt.I<ProfileStore>();
  final Post? post;

  PostItem({
    Key? key,
    this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Post? _post = post;
    bool isReclouted = false;
    String? posterName = _profileStore.userProfile.username;

    useEffect(() {
      // check if the post is a reclouted post
      if (post?.recloutedPostEntryResponse != null) {
        _post = post?.recloutedPostEntryResponse;
        isReclouted = true;

        // get profile of the person who reclouted this post
        posterName = post?.profileEntryResponse?.username;
      }
    }, []);

    // get avatar
    final avatar = processDataImage(_post?.profileEntryResponse?.profilePic);

    // get image urls for this post
    var imageUrl = '';
    if (_post?.imageUrls != null) {
      var l = _post?.imageUrls?.length;
      if (l! > 0) {
        imageUrl = _post?.imageUrls?[0];
      }
    }

    final int given = _post?.timestampNanos as int;
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
      child: Column(
        children: [
          Visibility(
            visible: isReclouted,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0, left: 14.0),
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(color: Colors.white60),
                      children: [
                        WidgetSpan(
                          child: Icon(
                            CupertinoIcons.arrow_2_squarepath,
                            size: 16.0,
                            color: Colors.white60,
                          ),
                        ),
                        TextSpan(text: '  @$posterName reclouted'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 48,
                width: 48,
                margin: EdgeInsets.fromLTRB(12.0, 0.0, 14.0, 8.0),
                decoration: BoxDecoration(
                  color: Palette.background,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Image.memory(avatar),
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: GestureDetector(
                        onTap: Feedback.wrapForTap(() {
                          String? username =
                              _post?.profileEntryResponse?.username!;
                          AutoRouter.of(context)
                              .push(ExploreProfileRoute(username: username!));
                        }, context),
                        child: Text(
                          '@${_post?.profileEntryResponse?.username}',
                          style: TextStyle(
                            color: Palette.primary4,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 2, top: 4, bottom: 6),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: '$timeElapsed',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: ParsedText(
                        text: _post?.body ?? '',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          height: 1.3,
                          wordSpacing: 0.2,
                        ),
                        parse: <MatchText>[
                          MatchText(
                            pattern: r"(?<![A-Za-z])@[A-Za-z]\w+",
                            style: TextStyle(
                              color: Palette.primary3,
                              fontSize: 15,
                            ),
                            onTap: (String name) {
                              AutoRouter.of(context).push(ExploreProfileRoute(
                                  username: name.substring(1)));
                              print(name);
                            },
                          ),
                          MatchText(
                            type: ParsedType.URL,
                            style: TextStyle(
                              color: Palette.primary3,
                              fontSize: 15,
                            ),
                            onTap: (url) {
                              launchURL(url);
                              // print(url);
                            },
                          ),
                          MatchText(
                            type: ParsedType.EMAIL,
                            style: TextStyle(
                              color: Palette.primary3,
                              fontSize: 15,
                            ),
                            onTap: (email) {
                              print(email);
                            },
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: _post?.body != '',
                      child: SizedBox(height: 14),
                    ),
                    Visibility(
                      visible: imageUrl != '',
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxHeight: 200),
                            child: GestureDetector(
                              onTap: Feedback.wrapForTap(() {
                                AutoRouter.of(context)
                                    .push(ImageViewerRoute(imageUrl: imageUrl));
                              }, context),
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
                    ),
                    Visibility(
                      visible: imageUrl != '',
                      child: SizedBox(height: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text.rich(
                            TextSpan(
                              style: TextStyle(color: Colors.white60),
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    CupertinoIcons.bubble_left,
                                    size: 18.0,
                                    color: Colors.white60,
                                  ),
                                ),
                                TextSpan(text: '  ${_post?.commentCount}'),
                              ],
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              style: TextStyle(color: Colors.white60),
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    CupertinoIcons.arrow_2_squarepath,
                                    size: 18.0,
                                    color: Colors.white60,
                                  ),
                                ),
                                TextSpan(text: '  ${_post?.recloutCount}'),
                              ],
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              style: TextStyle(color: Colors.white60),
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    CupertinoIcons.heart,
                                    size: 18.0,
                                    color: Colors.white60,
                                  ),
                                ),
                                TextSpan(text: '  ${_post?.likeCount}'),
                              ],
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              style: TextStyle(color: Colors.white60),
                              children: [],
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
        ],
      ),
    );
  }
}
