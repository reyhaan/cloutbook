// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:cloutbook/screens/screens.dart' as _i2;
import 'package:flutter/widgets.dart' as _i3;

class FlutterRouter extends _i1.RootStackRouter {
  FlutterRouter();

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    LoginRoute.name: (entry) {
      return _i1.AdaptivePage(entry: entry, child: _i2.LoginScreen());
    },
    NavRoute.name: (entry) {
      return _i1.AdaptivePage(entry: entry, child: _i2.NavScreen());
    },
    ProfileRoute.name: (entry) {
      var args = entry.routeData
          .argsAs<ProfileRouteArgs>(orElse: () => ProfileRouteArgs());
      return _i1.AdaptivePage(
          entry: entry,
          child: _i2.ProfileScreen(key: args.key, username: args.username));
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(LoginRoute.name, path: '/'),
        _i1.RouteConfig(NavRoute.name, path: '/nav-screen'),
        _i1.RouteConfig(ProfileRoute.name, path: '/profile-screen')
      ];
}

class LoginRoute extends _i1.PageRouteInfo {
  const LoginRoute() : super(name, path: '/');

  static const String name = 'LoginRoute';
}

class NavRoute extends _i1.PageRouteInfo {
  const NavRoute() : super(name, path: '/nav-screen');

  static const String name = 'NavRoute';
}

class ProfileRoute extends _i1.PageRouteInfo<ProfileRouteArgs> {
  ProfileRoute({_i3.Key? key, String username = ''})
      : super(name,
            path: '/profile-screen',
            args: ProfileRouteArgs(key: key, username: username));

  static const String name = 'ProfileRoute';
}

class ProfileRouteArgs {
  const ProfileRouteArgs({this.key, this.username = ''});

  final _i3.Key? key;

  final String username;
}
