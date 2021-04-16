import 'package:cloutbook/config/palette.dart';
import 'package:cloutbook/widgets/FavoriteList.dart';
import 'package:cloutbook/widgets/SearchBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends StatefulWidget {
  ExploreScreen({Key key}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<String> itemList = [];

  @override
  void initState() {
    for (int count = 0; count < 50; count++) {
      itemList.add("Item $count");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
          return <Widget>[
            createSilverAppBar1(),
            createSilverAppBar2(),
          ];
        },
        body: FavoriteList(),
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
                  .headline6
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
