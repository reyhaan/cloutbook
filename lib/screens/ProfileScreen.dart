import 'package:cloutbook/stores/ProfileStore.dart';
import 'package:cloutbook/widgets/Posts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class ProfileScreen extends HookWidget {
  final ProfileStore _profileStore = GetIt.I<ProfileStore>();
  final String? username;

  ProfileScreen({
    Key? key,
    this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      if (username == null) {
        return;
      }
      if (username != null) {
        _profileStore.getUserProfile(
            username:
                username!.isEmpty ? _profileStore.loggedInProfile : username);
      }
    }, []);

    return Scaffold(
      body: Observer(
        builder: (context) {
          return Stack(
            children: [
              Positioned(
                child: Center(
                  child: Visibility(
                    visible: _profileStore.isLoading,
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
              Positioned.fill(
                child: Visibility(
                  visible: !_profileStore.isLoading,
                  child: Posts(
                    posts: _profileStore.userProfile.posts,
                    isProfile: true,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
