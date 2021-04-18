import 'package:cloutbook/assets.dart';
import 'package:cloutbook/common/utils.dart';
import 'package:cloutbook/stores/ProfileStore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';

class ProfileHeader extends HookWidget {
  final ProfileStore _profileStore = GetIt.I<ProfileStore>();

  @override
  Widget build(BuildContext context) {
    final avatar = processDataImage(_profileStore.userProfile.profilePic);

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            width: 100,
            margin: EdgeInsets.fromLTRB(40.0, 32.0, 8.0, 20.0),
            decoration: BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 4),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.memory(avatar),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 40, top: 4.0, bottom: 16.0),
            child: Text(
              '@${_profileStore.userProfile.username}',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 40, right: 40),
            margin: EdgeInsets.only(bottom: 5.0),
            child: Text(
              '${_profileStore.userProfile.description}',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 14, color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}
