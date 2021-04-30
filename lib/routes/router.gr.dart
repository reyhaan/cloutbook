// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:cloutbook/models/PostModel.dart' as _i7;
import 'package:cloutbook/screens/ExploreProfileScreen.dart' as _i3;
import 'package:cloutbook/screens/PostViewerScreen.dart' as _i5;
import 'package:cloutbook/screens/screens.dart' as _i2;
import 'package:cloutbook/screens/SearchScreen.dart' as _i4;
import 'package:flutter/material.dart' as _i6;

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
          child: _i2.ProfileScreen(
              key: args.key,
              username: args.username,
              shouldGoBackToRoot: args.shouldGoBackToRoot));
    },
    ExploreProfileRoute.name: (entry) {
      var args = entry.routeData.argsAs<ExploreProfileRouteArgs>(
          orElse: () => ExploreProfileRouteArgs());
      return _i1.AdaptivePage(
          entry: entry,
          child: _i3.ExploreProfileScreen(
              key: args.key,
              username: args.username,
              shouldGoBackToRoot: args.shouldGoBackToRoot));
    },
    ImageViewerRoute.name: (entry) {
      var args = entry.routeData
          .argsAs<ImageViewerRouteArgs>(orElse: () => ImageViewerRouteArgs());
      return _i1.AdaptivePage(
          entry: entry,
          child: _i2.ImageViewerScreen(key: args.key, imageUrl: args.imageUrl));
    },
    SearchRoute.name: (entry) {
      var args = entry.routeData
          .argsAs<SearchRouteArgs>(orElse: () => SearchRouteArgs());
      return _i1.AdaptivePage(
          entry: entry, child: _i4.SearchScreen(key: args.key));
    },
    PostViewerRoute.name: (entry) {
      var args = entry.routeData
          .argsAs<PostViewerRouteArgs>(orElse: () => PostViewerRouteArgs());
      return _i1.AdaptivePage(
          entry: entry,
          child: _i5.PostViewerScreen(key: args.key, post: args.post));
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(LoginRoute.name, path: '/'),
        _i1.RouteConfig(NavRoute.name, path: '/nav-screen'),
        _i1.RouteConfig(ProfileRoute.name, path: '/profile-screen'),
        _i1.RouteConfig(ExploreProfileRoute.name,
            path: '/explore-profile-screen'),
        _i1.RouteConfig(ImageViewerRoute.name, path: '/image-viewer-screen'),
        _i1.RouteConfig(SearchRoute.name, path: '/search-screen'),
        _i1.RouteConfig(PostViewerRoute.name, path: '/post-viewer-screen')
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
  ProfileRoute({_i6.Key? key, String? username, bool? shouldGoBackToRoot})
      : super(name,
            path: '/profile-screen',
            args: ProfileRouteArgs(
                key: key,
                username: username,
                shouldGoBackToRoot: shouldGoBackToRoot));

  static const String name = 'ProfileRoute';
}

class ProfileRouteArgs {
  const ProfileRouteArgs({this.key, this.username, this.shouldGoBackToRoot});

  final _i6.Key? key;

  final String? username;

  final bool? shouldGoBackToRoot;
}

class ExploreProfileRoute extends _i1.PageRouteInfo<ExploreProfileRouteArgs> {
  ExploreProfileRoute(
      {_i6.Key? key, String? username, bool? shouldGoBackToRoot})
      : super(name,
            path: '/explore-profile-screen',
            args: ExploreProfileRouteArgs(
                key: key,
                username: username,
                shouldGoBackToRoot: shouldGoBackToRoot));

  static const String name = 'ExploreProfileRoute';
}

class ExploreProfileRouteArgs {
  const ExploreProfileRouteArgs(
      {this.key, this.username, this.shouldGoBackToRoot});

  final _i6.Key? key;

  final String? username;

  final bool? shouldGoBackToRoot;
}

class ImageViewerRoute extends _i1.PageRouteInfo<ImageViewerRouteArgs> {
  ImageViewerRoute({_i6.Key? key, dynamic imageUrl})
      : super(name,
            path: '/image-viewer-screen',
            args: ImageViewerRouteArgs(key: key, imageUrl: imageUrl));

  static const String name = 'ImageViewerRoute';
}

class ImageViewerRouteArgs {
  const ImageViewerRouteArgs({this.key, this.imageUrl});

  final _i6.Key? key;

  final dynamic imageUrl;
}

class SearchRoute extends _i1.PageRouteInfo<SearchRouteArgs> {
  SearchRoute({_i6.Key? key})
      : super(name, path: '/search-screen', args: SearchRouteArgs(key: key));

  static const String name = 'SearchRoute';
}

class SearchRouteArgs {
  const SearchRouteArgs({this.key});

  final _i6.Key? key;
}

class PostViewerRoute extends _i1.PageRouteInfo<PostViewerRouteArgs> {
  PostViewerRoute({_i6.Key? key, _i7.Post? post})
      : super(name,
            path: '/post-viewer-screen',
            args: PostViewerRouteArgs(key: key, post: post));

  static const String name = 'PostViewerRoute';
}

class PostViewerRouteArgs {
  const PostViewerRouteArgs({this.key, this.post});

  final _i6.Key? key;

  final _i7.Post? post;
}
