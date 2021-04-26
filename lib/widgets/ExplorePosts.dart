import 'package:auto_route/auto_route.dart';
import 'package:cloutbook/common/utils.dart';
import 'package:cloutbook/config/palette.dart';
import 'package:cloutbook/models/PostModel.dart';
import 'package:cloutbook/routes/router.dart';
import 'package:cloutbook/stores/ExchangeStore.dart';
import 'package:cloutbook/stores/ExploreProfileStore.dart';
import 'package:cloutbook/stores/GlobalFeedStore.dart';
import 'package:cloutbook/widgets/ProfileHeader.dart';
import 'package:cloutbook/widgets/ProfileMetadata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class ExplorePosts extends HookWidget {
  final GlobalFeedStore _globalFeedStore = GetIt.I<GlobalFeedStore>();
  final List<Post> posts;
  final bool isProfile;

  ExplorePosts({
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
  final ExploreProfileStore _profileStore = GetIt.I<ExploreProfileStore>();
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
                      child: GestureDetector(
                        onTap: () {
                          String? username =
                              _post?.profileEntryResponse?.username!;
                          AutoRouter.of(context)
                              .push(ExploreProfileRoute(username: username!));
                        },
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
                              onTap: () {
                                AutoRouter.of(context)
                                    .push(ImageViewerRoute(imageUrl: imageUrl));
                              },
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

class ProfileHeader extends HookWidget {
  final ExploreProfileStore _profileStore = GetIt.I<ExploreProfileStore>();

  @override
  Widget build(BuildContext context) {
    final avatar = processDataImage(_profileStore.userProfile.profilePic ?? '');
    // print(AutoRouter.of(context).routeData);

    return Container(
      child: Stack(
        children: [
          Positioned(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Color(0xFF0A0A0A),
                    ),
                    child: SizedBox(
                      height: 100,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Color(0xFF0A0A0A),
                        ),
                        child: SizedBox(
                          height: 50,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.fromLTRB(14.0, 0.0, 8.0, 12.0),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        border: Border.all(color: Colors.white60, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Visibility(
                          visible: _profileStore.userProfile.profilePic != null,
                          child: Image.memory(avatar),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 14, top: 0.0, bottom: 16.0),
                  child: Text(
                    '@ ${_profileStore.userProfile.username}',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 14, right: 40),
                  margin: EdgeInsets.only(bottom: 24.0),
                  child: ParsedText(
                    text:
                        '${_profileStore.userProfile.description}'.trimRight(),
                    alignment: TextAlign.start,
                    style: TextStyle(
                        fontSize: 13, color: Colors.white, height: 1.4),
                    parse: <MatchText>[
                      MatchText(
                        type: ParsedType.URL,
                        style: TextStyle(
                          color: Palette.primary4,
                          fontSize: 15,
                        ),
                        onTap: (url) {
                          print(url);
                        },
                      ),
                      MatchText(
                        type: ParsedType.EMAIL,
                        style: TextStyle(
                          color: Palette.primary4,
                          fontSize: 15,
                        ),
                        onTap: (url) {
                          print(url);
                        },
                      ),
                      MatchText(
                        pattern: r"(?<![A-Za-z])@[A-Za-z]\w+",
                        style: TextStyle(
                          color: Palette.primary4,
                          fontSize: 15,
                        ),
                        onTap: (name) {
                          print(name);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileMetadata extends HookWidget {
  final ExploreProfileStore _profileStore = GetIt.I<ExploreProfileStore>();
  final ExchangeStore _exchangeStore = GetIt.I<ExchangeStore>();

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      // get latest exchange rates first
      _exchangeStore.updateExchange();
    }, []);

    useEffect(() {
      // reset store when unmounted
      return _exchangeStore.disposeWebViews;
    }, []);

    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(14),
                    margin: EdgeInsets.only(left: 12, right: 7),
                    decoration: BoxDecoration(
                      color: Palette.foreground,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      children: [
                        Observer(builder: (_) {
                          final formatter = new NumberFormat("#,###");
                          String followers = formatter.format(
                              int.parse(_profileStore.userProfile.followers!));
                          return Text(
                            followers,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }),
                        SizedBox(height: 8),
                        Text('Followers',
                            style: TextStyle(
                              color: Colors.grey,
                            )),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(14),
                    margin: EdgeInsets.only(left: 7, right: 12),
                    decoration: BoxDecoration(
                      color: Palette.foreground,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      children: [
                        Observer(builder: (_) {
                          final formatter = new NumberFormat("#,###.##");
                          final coinPrice = formatter
                              .format(double.parse(_profileStore.coinPrice));
                          return Text(
                            '\$$coinPrice',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }),
                        SizedBox(height: 8),
                        Text(
                          'Coin Price',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Container(
          //   margin: EdgeInsets.only(bottom: 16, left: 12, right: 12),
          //   padding: EdgeInsets.only(top: 22, bottom: 22),
          //   decoration: BoxDecoration(
          //     color: Palette.foreground,
          //     borderRadius: BorderRadius.circular(14),
          //   ),
          //   child: Observer(builder: (coontext) {
          //     var totalUSDLocked = NumberFormat.compact()
          //         .format(double.parse(_profileStore.totalUSDLocked));
          //     var totalUSDMarketCap = NumberFormat.compact()
          //         .format(double.parse(_profileStore.totalUSDMarketCap));
          //     return Row(
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       mainAxisAlignment: MainAxisAlignment.spaceAround,
          //       children: [
          //         Container(
          //           constraints: BoxConstraints(minWidth: 100, maxWidth: 100),
          //           child: Column(
          //             children: [
          //               Text('${_profileStore.inCirculation}'),
          //               SizedBox(height: 8),
          //               Text(
          //                 'In Circulation',
          //                 textAlign: TextAlign.center,
          //                 style: TextStyle(
          //                     fontSize: 12,
          //                     // fontFamily: GoogleFonts.robotoMono().fontFamily,
          //                     color: Colors.grey),
          //               ),
          //             ],
          //           ),
          //         ),
          //         Container(
          //           constraints: BoxConstraints(minWidth: 100, maxWidth: 100),
          //           child: Column(
          //             children: [
          //               Text('\$$totalUSDLocked'),
          //               SizedBox(height: 8),
          //               Text(
          //                 'Total Locked',
          //                 textAlign: TextAlign.center,
          //                 style: TextStyle(
          //                     fontSize: 12,
          //                     // fontFamily: GoogleFonts.robotoMono().fontFamily,
          //                     color: Colors.grey),
          //               ),
          //             ],
          //           ),
          //         ),
          //         Container(
          //           constraints: BoxConstraints(minWidth: 90, maxWidth: 90),
          //           child: Column(
          //             children: [
          //               Text('\$$totalUSDMarketCap'),
          //               SizedBox(height: 8),
          //               Text(
          //                 'Market Cap',
          //                 textAlign: TextAlign.center,
          //                 style: TextStyle(
          //                     fontSize: 12,
          //                     // fontFamily: GoogleFonts.robotoMono().fontFamily,
          //                     color: Colors.grey),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ],
          //     );
          //   }),
          // ),
          Container(
            padding: const EdgeInsets.fromLTRB(18, 14, 10, 16),
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1.0,
                  color: Palette.foreground,
                ),
                top: BorderSide(
                  width: 1.0,
                  color: Palette.foreground,
                ),
              ),
            ),
            child: Row(
              children: [
                Text(
                  'Posts',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
