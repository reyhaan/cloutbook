import 'package:auto_route/auto_route.dart';
import 'package:cloutbook/assets.dart';
import 'package:cloutbook/common/utils.dart';
import 'package:cloutbook/config/palette.dart';
import 'package:cloutbook/models/LoggedInUserModel.dart';
import 'package:cloutbook/routes/router.dart';
import 'package:cloutbook/stores/AuthStore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';

import '../stores/ProfileStore.dart';

final TextEditingController? _usernameController = TextEditingController();
final ProfileStore _profileStore = GetIt.I<ProfileStore>();
final AuthStore _authStore = GetIt.I<AuthStore>();

class LoginScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    useEffect(() {}, []);
    // check if there's a user who is already loggedIn and set it to store
    LoggedInUser? loggedInUser = _authStore.getLoggedInUser();

    if (loggedInUser != null) {
      _profileStore.loggedInProfile = loggedInUser!.username;
      _authStore.setLoggedInUser(loggedInUser);
      AutoRouter.of(context).replace(NavRoute());
    }

    List<LoggedInUser> allUsers = _authStore.getAllUsers();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    height: 55,
                    margin: EdgeInsets.fromLTRB(8.0, 40.0, 8.0, 10.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Assets.logoRound),
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                    margin: EdgeInsets.fromLTRB(
                      8.0,
                      10.0,
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
                            controller: _usernameController,
                            style: TextStyle(color: Colors.white),
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
                    onTap: () async {
                      if (_usernameController!.text.isNotEmpty) {
                        String username = _usernameController!.text;

                        // check if already added
                        bool isUserAlreadyAdded =
                            _authStore.isUserAlreadyAdded(username);

                        if (isUserAlreadyAdded) {
                          // user already added, just mark it logged in and Nav to Home page
                          LoggedInUser user =
                              _authStore.getUserByName(username);
                          user.isLoggedIn = true;
                          _authStore.updateUser(user);
                          _authStore.setLoggedInUser(user);
                          _profileStore.loggedInProfile = user.username;
                          AutoRouter.of(context).replace(NavRoute());
                        } else {
                          // make a request to fetch this user from bitclout
                          final profile = await _profileStore
                              .getProfileByUsername(username: username);

                          // create a new LoggedInUser object
                          LoggedInUser newUser = LoggedInUser(
                            username: username,
                            publicKey: profile.publicKeyBase58Check!,
                            profilePic: profile.profilePic!,
                            isLoggedIn: true,
                          );

                          // save to hive database
                          _authStore.addUser(newUser);
                          _profileStore.loggedInProfile = newUser.username;
                          AutoRouter.of(context).replace(NavRoute());
                        }
                      }
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
                    padding: const EdgeInsets.only(
                        top: 30.0, left: 30.0, right: 30.0),
                    child: Text(
                      'Start by adding a profile by username, please do not enter your seed phrase!',
                      style: TextStyle(color: Palette.hintColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Container(
                padding: EdgeInsets.only(top: 18),
                margin: EdgeInsets.only(left: 4, right: 4),
                decoration: BoxDecoration(
                  color: Palette.foreground,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Column(
                  children: [
                    Text('Recently viewed',
                        style: TextStyle(color: Colors.grey)),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Wrap(
                        children: allUsers.map(
                          (user) {
                            final avatar = processDataImage(user.profilePic);
                            return GestureDetector(
                              onTap: Feedback.wrapForTap(() {
                                user.isLoggedIn = true;
                                _authStore.updateUser(user);
                                _authStore.setLoggedInUser(user);
                                _profileStore.loggedInProfile = user.username;
                                AutoRouter.of(context).replace(NavRoute());
                              }, context),
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 48,
                                      width: 48,
                                      margin: EdgeInsets.fromLTRB(
                                          12.0, 0.0, 14.0, 8.0),
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Colors.white, width: 2),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(21),
                                        child: Image.memory(avatar),
                                      ),
                                    ),
                                    Text(user.username),
                                  ],
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
