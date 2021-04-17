import 'package:cloutbook/config/palette.dart';
import 'package:cloutbook/stores/GlobalFeedStore.dart';
import 'package:cloutbook/widgets/Posts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class HomeScreen extends StatelessWidget {
  final GlobalFeedStore _globalFeedStore = GetIt.I<GlobalFeedStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
          return <Widget>[
            createHomeSilverAppBar(),
          ];
        },
        body: Observer(
          builder: (context) {
            return Posts(
              posts: _globalFeedStore.globalFeed,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search),
        onPressed: () {
          _globalFeedStore.getGlobalFeed();
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
