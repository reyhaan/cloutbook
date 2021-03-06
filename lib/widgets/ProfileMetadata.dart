import 'package:cloutbook/config/palette.dart';
import 'package:cloutbook/stores/ExchangeStore.dart';
import 'package:cloutbook/stores/ProfileStore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class ProfileMetadata extends HookWidget {
  final ProfileStore _profileStore = GetIt.I<ProfileStore>();
  final ExchangeStore _exchangeStore = GetIt.I<ExchangeStore>();

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      // reset store when unmounted
      _exchangeStore.disposeWebViews();

      // get latest exchange rates first
      _exchangeStore.updateExchange();
    }, []);

    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(14),
                    margin: EdgeInsets.only(left: 12, right: 7),
                    decoration: BoxDecoration(
                      color: Palette.foreground,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      children: [
                        Observer(builder: (_) {
                          final formatter = new NumberFormat("#,###");
                          String followers = formatter.format(
                              int.parse(_profileStore.userProfile.followers!));
                          return Text(
                            followers,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }),
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
                    padding: EdgeInsets.all(14),
                    margin: EdgeInsets.only(left: 7, right: 12),
                    decoration: BoxDecoration(
                      color: Palette.foreground,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      children: [
                        Observer(builder: (_) {
                          final formatter = new NumberFormat("#,###.##");
                          final coinPrice = formatter
                              .format(double.parse(_profileStore.coinPrice));
                          return Text(
                            '\$$coinPrice',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }),
                        SizedBox(height: 8),
                        Text(
                          'Coin Price',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 0, left: 0, right: 0),
            padding: EdgeInsets.only(top: 16, bottom: 18),
            decoration: BoxDecoration(
              color: Palette.background,
              border: Border(
                top: BorderSide(
                  width: 1.0,
                  color: Palette.foreground,
                ),
              ),
            ),
            child: Observer(builder: (coontext) {
              var totalUSDLocked = NumberFormat.compact()
                  .format(double.parse(_profileStore.totalUSDLocked));
              var totalUSDMarketCap = NumberFormat.compact()
                  .format(double.parse(_profileStore.totalUSDMarketCap));
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    constraints: BoxConstraints(minWidth: 100, maxWidth: 100),
                    child: Column(
                      children: [
                        Text('${_profileStore.inCirculation}'),
                        SizedBox(height: 8),
                        Text(
                          'In Circulation',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12,
                              // fontFamily: GoogleFonts.robotoMono().fontFamily,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(minWidth: 100, maxWidth: 100),
                    child: Column(
                      children: [
                        Text('\$$totalUSDLocked'),
                        SizedBox(height: 8),
                        Text(
                          'Total Locked',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12,
                              // fontFamily: GoogleFonts.robotoMono().fontFamily,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(minWidth: 90, maxWidth: 90),
                    child: Column(
                      children: [
                        Text('\$$totalUSDMarketCap'),
                        SizedBox(height: 8),
                        Text(
                          'Market Cap',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12,
                              // fontFamily: GoogleFonts.robotoMono().fontFamily,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 14, 10, 0),
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
                Column(
                  children: [
                    Text(
                      'Posts',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 14),
                    Container(
                      height: 2,
                      width: 70,
                      color: Palette.primary3,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
