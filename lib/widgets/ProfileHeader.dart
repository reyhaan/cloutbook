import 'package:cloutbook/common/utils.dart';
import 'package:cloutbook/config/palette.dart';
import 'package:cloutbook/stores/ProfileStore.dart';
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            width: 100,
            margin: EdgeInsets.fromLTRB(14.0, 32.0, 8.0, 12.0),
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
          Container(
            margin: EdgeInsets.only(left: 14, top: 0.0, bottom: 16.0),
            child: Text(
              '@${_profileStore.userProfile.username}',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 14, right: 40),
            margin: EdgeInsets.only(bottom: 5.0),
            child: ParsedText(
              text: '${_profileStore.userProfile.description}',
              alignment: TextAlign.start,
              style: TextStyle(fontSize: 14, color: Colors.white, height: 1.3),
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
                  pattern: r"\@[A-Za-z]\w+",
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
    );
  }
}
