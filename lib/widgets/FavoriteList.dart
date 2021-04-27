import 'package:auto_route/auto_route.dart';
import 'package:cloutbook/common/utils.dart';
import 'package:cloutbook/config/palette.dart';
import 'package:cloutbook/models/ProfileModel.dart';
import 'package:cloutbook/routes/router.dart';
import 'package:cloutbook/stores/ExchangeStore.dart';
import 'package:cloutbook/stores/ExploreStore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class FavoriteList extends HookWidget {
  final ExploreStore _exploreStore = GetIt.I<ExploreStore>();

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      _exploreStore.getWatchlist();
    }, []);

    return Container(
      child: Observer(builder: (_) {
        final watchlist = _exploreStore.savedProfiles;
        return ListView.builder(
          itemCount: watchlist.length,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(18, 14, 10, 10),
                        child: Text('Watchlist'),
                      ),
                    ],
                  ),
                  ListItem(profile: watchlist[index])
                ],
              );
            }
            return ListItem(profile: watchlist[index]);
          },
        );
      }),
    );
  }
}

class ListItem extends StatelessWidget {
  final ProfileEntryResponse? profile;
  final ExploreStore _exploreStore = GetIt.I<ExploreStore>();
  final ExchangeStore _exchangeStore = GetIt.I<ExchangeStore>();

  ListItem({
    Key? key,
    this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final avatar = processDataImage(profile?.profilePic);
    final formatter = new NumberFormat("#,###");
    final coinPrice = formatter.format(double.parse(
        _exchangeStore.getCoinPrice(profile?.coinPriceBitCloutNanos)));

    return GestureDetector(
      onTap: Feedback.wrapForTap(() {
        AutoRouter.of(context)
            .push(ExploreProfileRoute(username: profile?.username));
      }, context),
      child: Container(
        margin: EdgeInsets.fromLTRB(11, 0, 11, 8),
        padding: EdgeInsets.fromLTRB(10, 10, 8, 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: Palette.foreground,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 46,
                      width: 46,
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(23),
                        child: Image.memory(avatar),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            '@${profile?.username}',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          '243 Followers',
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.grey, fontSize: 12.0),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        '\$$coinPrice',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      '-2.30%',
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.green, fontSize: 12.0),
                    ),
                  ],
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () async {
                    // save item to watchlist
                    await _exploreStore.removeFromWatchlist(profile);
                  },
                  child: Container(
                    color: Palette.foreground,
                    padding: EdgeInsets.all(4),
                    child: Icon(
                      CupertinoIcons.minus_circle,
                      size: 18.0,
                      color: Palette.hintColor,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
