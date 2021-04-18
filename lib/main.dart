import 'package:cloutbook/common/api_client/api_client.dart';
import 'package:cloutbook/repository/HomeRepository.dart';
import 'package:cloutbook/repository/ProfileRepository.dart';
import 'package:cloutbook/stores/GlobalFeedStore.dart';
import 'package:cloutbook/stores/ProfileStore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloutbook/config/palette.dart';
import 'package:cloutbook/screens/screens.dart';

void main() {
  GetIt.I.registerSingleton<ApiClient>(ApiClient(Dio()));
  GetIt.I.registerSingleton<HomeRepository>(HomeRepository());
  GetIt.I.registerSingleton<ProfileRepository>(ProfileRepository());

  final homeRepository = GetIt.I<HomeRepository>();
  final profileRepository = GetIt.I<ProfileRepository>();

  GetIt.I.registerSingleton<GlobalFeedStore>(GlobalFeedStore(homeRepository));
  GetIt.I.registerSingleton<ProfileStore>(ProfileStore(profileRepository));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: MaterialApp(
        title: 'Cloutbook',
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => NavScreen(),
          '/home': (context) => NavScreen(),
        },
        theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: Palette.foreground),
          scaffoldBackgroundColor: Palette.background,
          primaryColor: Palette.primary,
          accentColor: Palette.primary,
          iconTheme: const IconThemeData(color: Colors.white),
          fontFamily: GoogleFonts.rubik().fontFamily,
          textTheme: GoogleFonts.rubikTextTheme(
            TextTheme(
              bodyText1: TextStyle(color: Colors.white),
              bodyText2: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
