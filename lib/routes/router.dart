import 'package:auto_route/auto_route.dart';
import 'package:cloutbook/screens/screens.dart';

export 'router.gr.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(page: LoginScreen, initial: true),
    AutoRoute(page: NavScreen),
  ],
)
class $FlutterRouter {}
