import 'package:cloutbook/config/palette.dart';
import 'package:flutter/material.dart';

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
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.only(top: 25, bottom: 30),
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
                        style: TextStyle(fontSize: 12),
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
                        style: TextStyle(fontSize: 12),
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
                        style: TextStyle(fontSize: 12),
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
