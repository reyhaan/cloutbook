import 'package:cloutbook/common/utils.dart';
import 'package:cloutbook/config/palette.dart';
import 'package:cloutbook/stores/ProfileStore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

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
                  padding: const EdgeInsets.only(top: 24.0, bottom: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        margin: EdgeInsets.fromLTRB(20.0, 0.0, 8.0, 0.0),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
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
                        margin:
                            EdgeInsets.only(left: 14, top: 4.0, bottom: 16.0),
                        child: Text(
                          '@${_profileStore.userProfile.username}',
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
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
                    Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
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
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.fromLTRB(8, 20, 16, 0),
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
                    Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
                      decoration: BoxDecoration(
                          color: Palette.foreground,
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Row(
                        children: [
                          Container(
                            child: Text('Contact developer'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
                      decoration: BoxDecoration(
                          color: Palette.foreground,
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Row(
                        children: [
                          Container(
                            child: Text('Provide feedback'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
                      decoration: BoxDecoration(
                          color: Palette.foreground,
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Row(
                        children: [
                          Container(
                            child: Text('Request feature'),
                          ),
                        ],
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
