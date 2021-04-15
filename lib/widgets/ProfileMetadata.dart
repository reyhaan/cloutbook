import 'package:cloutbook/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileMetadata extends StatefulWidget {
  ProfileMetadata({Key key}) : super(key: key);

  @override
  _ProfileMetadataState createState() => _ProfileMetadataState();
}

class _ProfileMetadataState extends State<ProfileMetadata> {
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
                Text('16 Followers'),
                Text('~\$3.40 Coin Price'),
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
