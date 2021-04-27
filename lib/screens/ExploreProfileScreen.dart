import 'package:auto_route/auto_route.dart';
import 'package:cloutbook/stores/ExploreProfileStore.dart';
import 'package:cloutbook/widgets/ExplorePosts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class ExploreProfileScreen extends HookWidget {
  final ExploreProfileStore _profileStore = GetIt.I<ExploreProfileStore>();
  final String? username;
  final bool? shouldGoBackToRoot;

  ExploreProfileScreen({
    Key? key,
    this.username,
    this.shouldGoBackToRoot,
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
                  child: ExplorePosts(
                    posts: _profileStore.userProfile.posts,
                    isProfile: true,
                  ),
                ),
              ),
              Positioned(
                top: 30,
                left: 20,
                child: Visibility(
                  visible: AutoRouter.of(context).current?.name != 'NavRoute',
                  child: GestureDetector(
                    onTap: Feedback.wrapForTap(() {
                      if (shouldGoBackToRoot == false) {
                        AutoRouter.of(context).pop();
                      } else {
                        AutoRouter.of(context).popUntilRoot();
                      }
                    }, context),
                    child: Container(
                      padding: EdgeInsets.all(12),
                      color: Color(0xFF0A0A0A),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
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
