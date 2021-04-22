import 'package:auto_route/auto_route.dart';
import 'package:cloutbook/assets.dart';
import 'package:cloutbook/config/palette.dart';
import 'package:cloutbook/routes/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

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
                Container(
                  margin: EdgeInsets.fromLTRB(30, 10, 30, 20),
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
                    AutoRouter.of(context).replace(NavRoute());
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
                      const EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
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
