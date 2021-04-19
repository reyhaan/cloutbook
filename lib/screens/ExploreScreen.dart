import 'package:cloutbook/config/palette.dart';
import 'package:cloutbook/stores/ExploreStore.dart';
import 'package:cloutbook/widgets/FavoriteList.dart';
import 'package:cloutbook/widgets/SearchBar.dart';
import 'package:cloutbook/widgets/SearchList.dart';
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
      return _exploreStore.reset;
    });

    return Scaffold(
      body: Observer(builder: (_) {
        return NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
            return <Widget>[
              createSilverAppBar1(),
              createSilverAppBar2(),
            ];
          },
          body: (_exploreStore.profiles.length > 0)
              ? SearchList()
              : FavoriteList(),
        );
      }),
    );
  }
}

SliverAppBar createSilverAppBar1() {
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
              'Explore',
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

SliverAppBar createSilverAppBar2() {
  return SliverAppBar(
    backgroundColor: Palette.background,
    pinned: true,
    collapsedHeight: 65,
    title: SearchBar(),
  );
}
