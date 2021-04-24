import 'package:auto_route/auto_route.dart';
import 'package:cloutbook/config/palette.dart';
import 'package:cloutbook/stores/ExploreStore.dart';
import 'package:cloutbook/widgets/FavoriteList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class ExploreScreen extends HookWidget {
  final ExploreStore _exploreStore = GetIt.I<ExploreStore>();

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      _exploreStore.getWatchlist();
      return _exploreStore.reset;
    }, []);

    return Scaffold(
      body: Observer(
        builder: (_) {
          return NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
              return <Widget>[
                createSilverAppBar1(),
                createSilverAppBar2(),
              ];
            },
            body:
                (_exploreStore.savedProfiles.length > 0) ? FavoriteList() : Center(child: Text('Nothing to show here')),
          );
        },
      ),
    );
  }
}

SliverAppBar createSilverAppBar1() {
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Explore',
                  style:
                      Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.all(6),
                margin: EdgeInsets.only(right: 6),
                child: GestureDetector(
                  onTap: Feedback.wrapForTap(() {
                    AutoRouter.of(context).pushPath('/search-screen');
                  }, context),
                  child: Container(
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Palette.foreground.withAlpha(180),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Icon(
                      CupertinoIcons.search,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }),
  );
}

SliverAppBar createSilverAppBar2() {
  return SliverAppBar(
    backgroundColor: Palette.background,
    pinned: true,
    collapsedHeight: 85,
    expandedHeight: 85,
    flexibleSpace: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 14,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\$4,567.17',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Wallet Balance',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
