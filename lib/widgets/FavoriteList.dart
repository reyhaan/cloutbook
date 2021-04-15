import 'package:cloutbook/assets.dart';
import 'package:cloutbook/config/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteList extends StatefulWidget {
  FavoriteList({Key key}) : super(key: key);

  @override
  _FavoriteListState createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 14, 10, 10),
                child: Text('Favorites'),
              ),
            ],
          ),
          ListItem(),
          ListItem(),
          ListItem(),
          ListItem(),
          ListItem(),
          ListItem(),
          ListItem(),
          ListItem()
        ],
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(11, 10, 11, 0),
      padding: EdgeInsets.fromLTRB(20, 14, 16, 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
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
                    height: 38,
                    width: 38,
                    margin: EdgeInsets.only(right: 14),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      image: DecorationImage(
                        image: AssetImage(Assets.avatar),
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          'mohammadrehaan',
                          style: TextStyle(color: Palette.primary4),
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        'Founder Reward: 25%',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Palette.textSecondary, fontSize: 12.0),
                      ),
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
              Icon(
                CupertinoIcons.xmark,
                size: 18.0,
                color: Palette.hintColor,
              ),
            ],
          )
        ],
      ),
    );
  }
}
