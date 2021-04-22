// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/widgets.dart' as _i3;

import '../screens/screens.dart' as _i2;

class AppRouter extends _i1.RootStackRouter {
  AppRouter();

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    HomeScreen.name: (entry) {
      return _i1.MaterialPageX(entry: entry, child: _i2.HomeScreen());
    },
    LoginScreen.name: (entry) {
      var args = entry.routeData
          .argsAs<LoginScreenArgs>(orElse: () => LoginScreenArgs());
      return _i1.MaterialPageX(
          entry: entry, child: _i2.LoginScreen(key: args.key));
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(HomeScreen.name, path: '/'),
        _i1.RouteConfig(LoginScreen.name, path: '/login'),
        _i1.RouteConfig('*#redirect',
            path: '*', redirectTo: '/', fullMatch: true)
      ];
}

class HomeScreen extends _i1.PageRouteInfo {
  const HomeScreen() : super(name, path: '/');

  static const String name = 'HomeScreen';
}

class LoginScreen extends _i1.PageRouteInfo<LoginScreenArgs> {
  LoginScreen({_i3.Key? key})
      : super(name, path: '/login', args: LoginScreenArgs(key: key));

  static const String name = 'LoginScreen';
}

class LoginScreenArgs {
  const LoginScreenArgs({this.key});

  final _i3.Key? key;
}
