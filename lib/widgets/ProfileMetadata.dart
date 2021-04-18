import 'package:cloutbook/config/palette.dart';
import 'package:cloutbook/stores/ExchangeStore.dart';
import 'package:cloutbook/stores/ProfileStore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileMetadata extends HookWidget {
  final ProfileStore _profileStore = GetIt.I<ProfileStore>();
  final ExchangeStore _exchangeStore = GetIt.I<ExchangeStore>();

  @override
  Widget build(BuildContext context) {
    void updateExchange() async {
      await _exchangeStore.getExchangeRate();
      await _exchangeStore.getTicker();
    }

    useEffect(() {
      // get latest exchange rates first
      updateExchange();

      // reset store when unmounted
      return _profileStore.reset;
    }, []);

    useEffect(() {
      // reset store when unmounted
      return _exchangeStore.disposeWebViews;
    }, []);

    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 16),
            child: Observer(
              builder: (context) {
                String followers = _profileStore.userFollowers;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.only(left: 10, right: 8),
                        decoration: BoxDecoration(
                          color: Palette.foreground,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Column(
                          children: [
                            Text(
                              followers,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text('Followers',
                                style: TextStyle(
                                  color: Colors.grey,
                                )),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.only(left: 8, right: 10),
                        decoration: BoxDecoration(
                          color: Palette.foreground,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Column(
                          children: [
                            Text(
                              '~\$470.40',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text('Coin Price',
                                style: TextStyle(
                                  color: Colors.grey,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20, left: 10, right: 10),
            padding: EdgeInsets.only(top: 20, bottom: 20),
            decoration: BoxDecoration(
              color: Palette.foreground,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  constraints: BoxConstraints(minWidth: 100, maxWidth: 100),
                  child: Column(
                    children: [
                      Text('~ 2.6104'),
                      SizedBox(height: 8),
                      Text(
                        'Coins in Circulation',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10,
                            fontFamily: GoogleFonts.robotoMono().fontFamily,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Container(
                  constraints: BoxConstraints(minWidth: 100, maxWidth: 100),
                  child: Column(
                    children: [
                      Text('~ \$2.96'),
                      SizedBox(height: 8),
                      Text(
                        'Total USD Locked',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10,
                            fontFamily: GoogleFonts.robotoMono().fontFamily,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Container(
                  constraints: BoxConstraints(minWidth: 90, maxWidth: 90),
                  child: Column(
                    children: [
                      Text('~ \$8.87'),
                      SizedBox(height: 8),
                      Text(
                        'USD Market Cap',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10,
                            fontFamily: GoogleFonts.robotoMono().fontFamily,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(18, 16, 10, 16),
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1.0,
                  color: Palette.foreground,
                ),
                top: BorderSide(
                  width: 1.0,
                  color: Palette.foreground,
                ),
              ),
            ),
            child: Row(
              children: [
                Text(
                  'Posts',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
