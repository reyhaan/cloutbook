import 'package:cloutbook/config/palette.dart';
import 'package:cloutbook/stores/ExchangeStore.dart';
import 'package:cloutbook/stores/ExploreStore.dart';
import 'package:cloutbook/stores/ProfileStore.dart';
import 'package:cloutbook/widgets/HoldingList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../config/palette.dart';

class WalletScreen extends HookWidget {
  final ExploreStore _exploreStore = GetIt.I<ExploreStore>();
  final ProfileStore _profileStore = GetIt.I<ProfileStore>();

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      _exploreStore.getWallet(_profileStore.userProfile.publicKeyBase58Check);
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
            body: HoldingList(),
          );
        },
      ),
    );
  }
}

SliverAppBar createSilverAppBar1() {
  final ExploreStore _exploreStore = GetIt.I<ExploreStore>();
  final ExchangeStore _exchangeStore = GetIt.I<ExchangeStore>();
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
                  'Wallet',
                  style:
                      Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.all(6),
                margin: EdgeInsets.only(right: 6),
                child: Container(
                  padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                  constraints: BoxConstraints(minWidth: 100),
                  decoration: BoxDecoration(
                    color: Palette.foreground.withAlpha(180),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Observer(builder: (_) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('\$${_exchangeStore.getCoinPrice(_exploreStore.balance)}',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        SizedBox(height: 2),
                        Text('Balance', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    );
                  }),
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
  final ExploreStore _exploreStore = GetIt.I<ExploreStore>();
  final ExchangeStore _exchangeStore = GetIt.I<ExchangeStore>();
  return SliverAppBar(
    backgroundColor: Palette.background,
    pinned: true,
    collapsedHeight: 125,
    expandedHeight: 125,
    flexibleSpace: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 14,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Observer(builder: (_) {
                  return Text(
                    '\$' + _exchangeStore.getCoinPrice(_exploreStore.balance).toString(),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  );
                }),
                SizedBox(height: 6),
                Text(
                  'Your Portfolio',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(child: WalletTabs())
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

class WalletTabs extends HookWidget {
  const WalletTabs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final segmentedControlGroupValue = useState(0);
    final Map<int, Widget> myTabs = const <int, Widget>{
      0: Text("Holdings"),
      1: Text("Holders"),
    };
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width - 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CupertinoSlidingSegmentedControl(
                  thumbColor: Palette.primary,
                  groupValue: segmentedControlGroupValue.value,
                  children: myTabs,
                  onValueChanged: (int? i) {
                    segmentedControlGroupValue.value = i!;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
