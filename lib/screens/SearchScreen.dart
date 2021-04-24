import 'package:cloutbook/config/palette.dart';
import 'package:cloutbook/stores/ExploreStore.dart';
import 'package:cloutbook/widgets/SearchBar.dart';
import 'package:cloutbook/widgets/SearchList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class SearchScreen extends HookWidget {
  final ExploreStore _exploreStore = GetIt.I<ExploreStore>();

  SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Observer(
            builder: (_) {
              return NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxScrolled) {
                  return <Widget>[
                    searchSliverAppBar(),
                  ];
                },
                body: (_exploreStore.profiles.length > 0)
                    ? SearchList()
                    : Center(
                        child: Text(
                          'Opps, we couldn\'t find anything!',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
              );
            },
          ),
        ),
      ),
    );
  }
}

SliverAppBar searchSliverAppBar() {
  return SliverAppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Palette.background,
    pinned: true,
    collapsedHeight: 70,
    title: SearchBar(),
  );
}
