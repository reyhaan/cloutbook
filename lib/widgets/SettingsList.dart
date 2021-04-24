import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:cloutbook/common/utils.dart';
import 'package:cloutbook/config/palette.dart';
import 'package:cloutbook/routes/router.dart';
import 'package:cloutbook/stores/ProfileStore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../config/palette.dart';

class SettingsList extends HookWidget {
  final ProfileStore _profileStore = GetIt.I<ProfileStore>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Observer(
          builder: (_) {
            final avatar =
                processDataImage(_profileStore.userProfile.profilePic ?? '');
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Visibility(
                            visible:
                                _profileStore.userProfile.profilePic != null,
                            child: Image.memory(avatar),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 0, top: 8.0, bottom: 6.0),
                        child: Text(
                          '@${_profileStore.userProfile.username}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Colors.white,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Transform.rotate(
                            angle: 90,
                            child: Icon(
                              Icons.vpn_key_rounded,
                              size: 16.0,
                              color: Colors.white60,
                            ),
                          ),
                          SizedBox(
                            width: 180.0,
                            child: Text(
                              '${_profileStore.userProfile.publicKeyBase58Check}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.fromLTRB(8, 8, 0, 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Row(
                        children: [
                          Container(
                            child: Text(
                              'Account',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: Feedback.wrapForTap(() {
                        _profileStore.loggedInProfile = '';
                        AutoRouter.of(context).replace(LoginRoute());
                      }, context),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                        decoration: BoxDecoration(
                            color: Palette.foreground,
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text('Sign Out'),
                            ),
                            Icon(
                              Icons.logout,
                              size: 18.0,
                              color: Palette.hintColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.fromLTRB(8, 8, 16, 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Row(
                        children: [
                          Container(
                            child: Text(
                              'Request & Feedback',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: Feedback.wrapForTap(() {
                        const url =
                            'mailto:hi@rehaan.ca?subject=Cloutbook: Bug Report&body=-via%20Habbit';
                        launchURL(url);
                      }, context),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                        decoration: BoxDecoration(
                          color: Palette.foreground,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              child: Text('Report bugs'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: Feedback.wrapForTap(() {
                        const url =
                            'mailto:hi@rehaan.ca?subject=Cloutbook: Feedback&body=-via%20Habbit';
                        launchURL(url);
                      }, context),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.fromLTRB(16, 1, 16, 0),
                        decoration: BoxDecoration(
                          color: Palette.foreground,
                        ),
                        child: Row(
                          children: [
                            Container(
                              child: Text('Provide feedback'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: Feedback.wrapForTap(() {
                        const url =
                            'mailto:hi@rehaan.ca?subject=Cloutbook: Feature Request&body=-via%20Habbit';
                        launchURL(url);
                      }, context),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.fromLTRB(16, 1, 16, 0),
                        decoration: BoxDecoration(
                          color: Palette.foreground,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              child: Text('Request a new feature'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
