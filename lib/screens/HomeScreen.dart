import 'package:cloutbook/config/palette.dart';
import 'package:cloutbook/controllers/Home/HomeController.dart';
import 'package:cloutbook/widgets/Posts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// https://api.bitclout.com/get-posts-stateless
// https://api.bitclout.com/get-exchange-rate
// https://api.bitclout.com/get-app-state

class HomeScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final HomeController homeStateProvider =
        useProvider(homeControllerProvider.notifier);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
          return <Widget>[
            createHomeSilverAppBar(),
          ];
        },
        body: Posts(
          posts: homeStateProvider.state.data?.value,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search),
        onPressed: () {
          homeStateProvider.getGlobalFeed(payload: {
            "PostHashHex": "",
            "ReaderPublicKeyBase58Check":
                "BC1YLgz2GMeUN28XtZQtXgYCT8Jhh9YSW2knS8r8L8EFuhdotVvLb17",
            "OrderBy": "newest",
            "StartTstampSecs": null,
            "PostContent": "",
            "NumToFetch": 50,
            "FetchSubcomments": false,
            "GetPostsForFollowFeed": true,
            "GetPostsForGlobalWhitelist": false,
            "GetPostsByClout": false,
            "PostsByCloutMinutesLookback": 0,
            "AddGlobalFeedBool": false
          });
        },
      ),
    );
  }
}

SliverAppBar createHomeSilverAppBar() {
  return SliverAppBar(
    backgroundColor: Colors.transparent,
    expandedHeight: 65,
    floating: false,
    elevation: 0,
    flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Container(
          color: Palette.background,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Global',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    }),
  );
}
