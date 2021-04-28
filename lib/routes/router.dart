import 'package:auto_route/auto_route.dart';
import 'package:cloutbook/screens/ExploreProfileScreen.dart';
import 'package:cloutbook/screens/PostViewerScreen.dart';
import 'package:cloutbook/screens/SearchScreen.dart';
import 'package:cloutbook/screens/screens.dart';

import '../screens/screens.dart';

export 'router.gr.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(page: LoginScreen, initial: true),
    AutoRoute(page: NavScreen),
    AutoRoute(page: ProfileScreen),
    AutoRoute(page: ExploreProfileScreen),
    AutoRoute(page: ImageViewerScreen),
    AutoRoute(page: SearchScreen),
    AutoRoute(page: PostViewerScreen),
  ],
)
class $FlutterRouter {}
