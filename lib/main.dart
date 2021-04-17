import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloutbook/config/palette.dart';
import 'package:cloutbook/screens/screens.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: ProviderScope(
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
      ),
    );
  }
}
