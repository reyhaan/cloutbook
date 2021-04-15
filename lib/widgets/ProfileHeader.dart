import 'package:cloutbook/assets.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatefulWidget {
  ProfileHeader({Key key}) : super(key: key);

  @override
  _ProfileHeaderState createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 100,
            width: 100,
            margin: EdgeInsets.fromLTRB(
              8.0,
              32.0,
              8.0,
              20.0,
            ),
            decoration: BoxDecoration(
              color: Colors.grey,
              image: DecorationImage(
                image: AssetImage(Assets.avatar),
              ),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 4),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 4.0, bottom: 8.0),
            child: Text(
              '@mohammadrehaan',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 40, right: 40),
            margin: EdgeInsets.only(bottom: 25.0),
            child: Text(
              'Developer with an alter ego of a designer. Does that make me a generalist?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
