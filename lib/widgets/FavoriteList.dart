import 'package:cloutbook/common/utils.dart';
import 'package:cloutbook/config/palette.dart';
import 'package:cloutbook/models/ProfileModel.dart';
import 'package:cloutbook/stores/ExploreStore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

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
                        padding: const EdgeInsets.fromLTRB(18, 14, 10, 0),
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

  ListItem({
    Key? key,
    this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final avatar = processDataImage(profile?.profilePic);

    return Container(
      margin: EdgeInsets.fromLTRB(11, 10, 11, 0),
      padding: EdgeInsets.fromLTRB(10, 14, 8, 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Palette.background,
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
                    height: 38,
                    width: 38,
                    margin: EdgeInsets.only(right: 18),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(21),
                      child: Image.memory(avatar),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          '${profile?.username}',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      // SizedBox(height: 5.0),
                      // Text(
                      //   'Founder Reward: 25%',
                      //   textAlign: TextAlign.left,
                      //   style: TextStyle(color: Colors.grey, fontSize: 12.0),
                      // ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Text('~\$3.50'),
              SizedBox(width: 20),
              GestureDetector(
                onTap: () async {
                  // save item to watchlist
                  await _exploreStore.removeFromWatchlist(profile);
                },
                child: Container(
                  color: Palette.background,
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    Icons.delete_outline,
                    size: 18.0,
                    color: Palette.hintColor,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
