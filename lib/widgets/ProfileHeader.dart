import 'package:cloutbook/common/utils.dart';
import 'package:cloutbook/config/palette.dart';
import 'package:cloutbook/stores/ProfileStore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:get_it/get_it.dart';

import '../config/palette.dart';

class ProfileHeader extends HookWidget {
  final ProfileStore _profileStore = GetIt.I<ProfileStore>();

  @override
  Widget build(BuildContext context) {
    final avatar = processDataImage(_profileStore.userProfile.profilePic ?? '');

    return Container(
      child: Stack(
        children: [
          Positioned(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Color(0xFF0A0A0A),
                    ),
                    child: SizedBox(
                      height: 100,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Color(0xFF0A0A0A),
                        ),
                        child: SizedBox(
                          height: 50,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.fromLTRB(14.0, 0.0, 8.0, 12.0),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        border: Border.all(color: Colors.white60, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Visibility(
                          visible: _profileStore.userProfile.profilePic != null,
                          child: Image.memory(avatar),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 0, top: 0.0, bottom: 16.0),
                  child: Text(
                    '@ ${_profileStore.userProfile.username}',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  margin: EdgeInsets.only(bottom: 24.0),
                  child: ParsedText(
                    text:
                        '${_profileStore.userProfile.description}'.trimRight(),
                    alignment: TextAlign.center,
                    style: TextStyle(
                        fontSize: 13, color: Colors.white, height: 1.4),
                    parse: <MatchText>[
                      MatchText(
                        type: ParsedType.URL,
                        style: TextStyle(
                          color: Palette.primary4,
                          fontSize: 15,
                        ),
                        onTap: (url) {
                          print(url);
                        },
                      ),
                      MatchText(
                        type: ParsedType.EMAIL,
                        style: TextStyle(
                          color: Palette.primary4,
                          fontSize: 15,
                        ),
                        onTap: (url) {
                          print(url);
                        },
                      ),
                      MatchText(
                        pattern: r"(?<![A-Za-z])@[A-Za-z]\w+",
                        style: TextStyle(
                          color: Palette.primary4,
                          fontSize: 15,
                        ),
                        onTap: (name) {
                          print(name);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
