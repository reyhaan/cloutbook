import 'dart:io';

import 'package:cloutbook/common/api_client/api_client.dart';
import 'package:cloutbook/models/HiveWatchlistModel.dart';
import 'package:cloutbook/repository/ExchangeRepository.dart';
import 'package:cloutbook/repository/ExploreRepository.dart';
import 'package:cloutbook/repository/HomeRepository.dart';
import 'package:cloutbook/repository/ProfileRepository.dart';
import 'package:cloutbook/routes/router.gr.dart';
import 'package:cloutbook/stores/ExchangeStore.dart';
import 'package:cloutbook/stores/ExploreStore.dart';
import 'package:cloutbook/stores/GlobalFeedStore.dart';
import 'package:cloutbook/stores/ProfileStore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get_it/get_it.dart';
import 'package:cloutbook/config/palette.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // setup Hive database
  await Hive.initFlutter();
  Hive.registerAdapter(WatchProfileAdapter());
  await Hive.openBox<WatchProfile>('watchProfile');
  await Hive.openBox<WatchProfile>('users');
  // await Hive.box<WatchProfile>('watchProfile').clear();

  // stuff needed for flutter inapp_webview
  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
    var swAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
    var swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

    if (swAvailable && swInterceptAvailable) {
      AndroidServiceWorkerController serviceWorkerController =
          AndroidServiceWorkerController.instance();

      serviceWorkerController.serviceWorkerClient = AndroidServiceWorkerClient(
        shouldInterceptRequest: (request) async {
          print(request);
          return null;
        },
      );
    }
  }

  // Registering all the things that we need from GetIt
  GetIt.I.registerSingleton<ApiClient>(ApiClient(Dio()));
  GetIt.I.registerSingleton<HomeRepository>(HomeRepository());
  GetIt.I.registerSingleton<ProfileRepository>(ProfileRepository());
  GetIt.I.registerSingleton<ExchangeRepository>(ExchangeRepository());
  GetIt.I.registerSingleton<ExploreRepository>(ExploreRepository());

  final homeRepository = GetIt.I<HomeRepository>();
  final profileRepository = GetIt.I<ProfileRepository>();
  final exchangeRepository = GetIt.I<ExchangeRepository>();
  final exploreRepository = GetIt.I<ExploreRepository>();

  GetIt.I.registerSingleton<GlobalFeedStore>(GlobalFeedStore(homeRepository));
  GetIt.I.registerSingleton<ProfileStore>(ProfileStore(profileRepository));
  GetIt.I.registerSingleton<ExchangeStore>(ExchangeStore(exchangeRepository));
  GetIt.I.registerSingleton<ExploreStore>(ExploreStore(exploreRepository));

  // Finally, running our app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FlutterRouter _flutterRouter = FlutterRouter();
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: MaterialApp.router(
        routerDelegate: _flutterRouter.delegate(),
        routeInformationParser: _flutterRouter.defaultRouteParser(),
        title: 'Cloutbook',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: Palette.foreground),
          scaffoldBackgroundColor: Palette.background,
          primaryColor: Palette.primary,
          accentColor: Palette.primary,
          iconTheme: const IconThemeData(color: Colors.white),
          fontFamily: 'SFProDisplay',
          textTheme: TextTheme(
            bodyText1:
                TextStyle(color: Colors.white, fontFamily: 'SFProDisplay'),
            bodyText2:
                TextStyle(color: Colors.white, fontFamily: 'SFProDisplay'),
          ),
        ),
      ),
    );
  }
}
