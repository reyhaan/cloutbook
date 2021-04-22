import 'package:auto_route/auto_route.dart';
import 'package:cloutbook/routes/authGuard.dart';
import 'package:cloutbook/screens/screens.dart';

export 'router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/',
      page: HomeScreen,
      guards: [],
    ),
    AutoRoute(path: '/login', page: LoginScreen, fullscreenDialog: false),
    RedirectRoute(path: '*', redirectTo: '/'),
  ],
)
class $AppRouter {}
