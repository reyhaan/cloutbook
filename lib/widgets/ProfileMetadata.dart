import 'package:cloutbook/config/palette.dart';
import 'package:cloutbook/stores/ProfileStore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileMetadata extends HookWidget {
  final ProfileStore _profileStore = GetIt.I<ProfileStore>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      '30',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text('Followers',
                        style: TextStyle(
                          color: Colors.grey,
                        )),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      '~\$470.40',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text('Coin Price',
                        style: TextStyle(
                          color: Colors.grey,
                        )),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.only(top: 20, bottom: 20),
            color: Palette.foreground,
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
          )
        ],
      ),
    );
  }
}
