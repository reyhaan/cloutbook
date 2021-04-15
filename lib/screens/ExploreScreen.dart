import 'package:cloutbook/widgets/FavoriteList.dart';
import 'package:cloutbook/widgets/SearchBar.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends StatefulWidget {
  ExploreScreen({Key key}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Explore',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 14,
          ),
          SearchBar(),
          FavoriteList(),
          SizedBox(height: 32)
        ],
      ),
    );
  }
}
