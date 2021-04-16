import 'package:cloutbook/assets.dart';
import 'package:cloutbook/config/palette.dart';
import 'package:cloutbook/screens/NavScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              bottom: 70,
              left: 0,
              right: 0,
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 35.0, left: 30.0, right: 30.0),
                child: Text(
                  'Copyright © 2021 • Cloutbook',
                  style: TextStyle(color: Palette.hintColor),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  height: 25,
                  margin: EdgeInsets.fromLTRB(
                    8.0,
                    120.0,
                    8.0,
                    40.0,
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Assets.logoFull),
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 20),
                //   child: Text(
                //     'Start by adding your profile',
                //     style: TextStyle(color: Palette.hintColor),
                //   ),
                // ),
                Container(
                  margin: EdgeInsets.fromLTRB(30, 10, 30, 40),
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Palette.secondaryForeground,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        CupertinoIcons.at,
                        size: 18.0,
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration.collapsed(
                              hintText: 'username or public key',
                              hintStyle: TextStyle(
                                  color: Palette.hintColor, fontSize: 14.0)),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NavScreen(),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.only(left: 30, right: 30),
                    decoration: BoxDecoration(
                        color: Palette.primary,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(CupertinoIcons.add,
                                size: 19.0, color: Colors.white),
                          ),
                          TextSpan(
                            text: '  Add profile',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              textBaseline: TextBaseline.ideographic,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 25.0, left: 30.0, right: 30.0),
                  child: Text(
                    'Start by adding your profile by username or public key, please do not enter your pass phrase!',
                    style: TextStyle(color: Palette.hintColor),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
