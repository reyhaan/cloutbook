import 'package:cloutbook/common/utils.dart';
import 'package:cloutbook/config/palette.dart';
import 'package:cloutbook/models/ProfileModel.dart';
import 'package:cloutbook/stores/ExchangeStore.dart';
import 'package:cloutbook/stores/ExploreStore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class SearchList extends HookWidget {
  final ExploreStore _exploreStore = GetIt.I<ExploreStore>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Observer(builder: (_) {
        final searchResults = _exploreStore.profiles;
        return ListView.builder(
          itemCount: searchResults.length,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(18, 14, 10, 0),
                        child: Text('${searchResults.length} Results'),
                      ),
                    ],
                  ),
                  ListItem(profile: searchResults[index])
                ],
              );
            }
            return ListItem(profile: searchResults[index]);
          },
        );
      }),
    );
  }
}

class ListItem extends HookWidget {
  final ProfileEntryResponse? profile;
  final ExploreStore _exploreStore = GetIt.I<ExploreStore>();
  final ExchangeStore _exchangeStore = GetIt.I<ExchangeStore>();
  final bool? render;

  ListItem({
    Key? key,
    this.profile,
    this.render = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _profilePic = profile?.profilePic;
    var urlPattern =
        r"(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
    var match = new RegExp(urlPattern, caseSensitive: false)
        .firstMatch(_profilePic.toString());

    final rerender = useState(render);

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
                      child: match != null
                          ? Image.network('$_profilePic')
                          : Image.memory(processDataImage(_profilePic)),
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
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Text(
                  '~\$${_exchangeStore.getCoinPrice(profile?.coinPriceBitCloutNanos)}'),
              SizedBox(width: 20),
              GestureDetector(
                onTap: () async {
                  // save item to watchlist
                  final bool inList = _exploreStore.isInWatchlist(profile);

                  if (inList) {
                    // remove this item from watch list
                    await _exploreStore.removeFromWatchlist(profile);
                  } else {
                    // add this item to watch list
                    await _exploreStore.addToWatchlist(profile!);
                  }
                  rerender.value = !rerender.value!;
                },
                child: Container(
                  color: Palette.background,
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    _exploreStore.isInWatchlist(profile)
                        ? Icons.star
                        : Icons.star_outline,
                    size: 22.0,
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
