import 'package:cloutbook/config/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 30, 0, 20),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Palette.secondaryForeground,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Icon(
            CupertinoIcons.search,
            size: 18.0,
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: TextField(
              decoration: InputDecoration.collapsed(
                  hintText: 'Seach',
                  hintStyle:
                      TextStyle(color: Palette.hintColor, fontSize: 14.0)),
            ),
          ),
        ],
      ),
    );
  }
}
