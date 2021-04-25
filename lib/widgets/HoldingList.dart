import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:cloutbook/common/utils.dart';
import 'package:cloutbook/config/palette.dart';
import 'package:cloutbook/models/HoldingModel.dart';
import 'package:cloutbook/routes/router.dart';
import 'package:cloutbook/stores/ExploreStore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class HoldingList extends HookWidget {
  final ExploreStore _exploreStore = GetIt.I<ExploreStore>();

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      _exploreStore.getWatchlist();
    }, []);

    return Container(
      child: Observer(builder: (_) {
        final watchlist = _exploreStore.didSelectHoldings
            ? _exploreStore.holdings
            : _exploreStore.hodlers;
        return ListView.builder(
          itemCount: watchlist.length,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Column(
                children: [
                  Row(
                    children: [SizedBox(height: 10)],
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
  final Holding? profile;

  ListItem({
    Key? key,
    this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Uint8List? avatar;
    if (profile?.profilePic != '') {
      avatar = processDataImage(profile?.profilePic);
    } else {
      avatar = null;
    }
    final formatter = new NumberFormat("#,###");
    final coinPrice = formatter.format(profile?.price);

    return GestureDetector(
      onTap: Feedback.wrapForTap(() {
        AutoRouter.of(context).push(ProfileRoute(username: profile?.username));
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
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(21),
                        child: avatar == null
                            ? CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Text('U'),
                              )
                            : Image.memory(avatar),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          constraints: BoxConstraints(
                              maxWidth:
                                  (MediaQuery.of(context).size.width / 2) - 40),
                          child: Text(
                            '@${profile?.username}',
                            overflow: TextOverflow.ellipsis,
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
                    // Text(
                    //   '-2.30%',
                    //   textAlign: TextAlign.left,
                    //   style: TextStyle(color: Colors.green, fontSize: 12.0),
                    // ),
                  ],
                ),
                SizedBox(width: 12.0),
              ],
            )
          ],
        ),
      ),
    );
  }
}
