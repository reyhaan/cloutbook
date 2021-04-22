import 'package:cloutbook/config/palette.dart';
import 'package:cloutbook/stores/ExchangeStore.dart';
import 'package:cloutbook/stores/GlobalFeedStore.dart';
import 'package:cloutbook/widgets/Posts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../stores/ProfileStore.dart';

class HomeScreen extends HookWidget {
  final GlobalFeedStore _globalFeedStore = GetIt.I<GlobalFeedStore>();
  final ExchangeStore _exchangeStore = GetIt.I<ExchangeStore>();
  final ProfileStore _profileStore = GetIt.I<ProfileStore>();

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      _exchangeStore.updateExchange();
      _globalFeedStore.getGlobalFeed();
      _profileStore.getUserProfile();

      // reset store when unmounted
      return _globalFeedStore.reset;
    }, []);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
          return <Widget>[
            createHomeSilverAppBar(),
          ];
        },
        body: Observer(
          builder: (context) {
            return Stack(
              children: [
                Visibility(
                  visible: true,
                  child: Positioned.fill(
                    child: Posts(
                      posts: _globalFeedStore.globalFeed,
                    ),
                  ),
                ),
                Visibility(
                  visible: _globalFeedStore.isLoading,
                  child: Positioned(
                    top: 100,
                    left: 0,
                    right: 0,
                    child: Center(child: CircularProgressIndicator()),
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

SliverAppBar createHomeSilverAppBar() {
  return SliverAppBar(
    backgroundColor: Colors.transparent,
    expandedHeight: 65,
    floating: false,
    elevation: 0,
    flexibleSpace: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Container(
          color: Palette.background,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Global',
              style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    }),
  );
}
