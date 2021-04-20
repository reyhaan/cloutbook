import 'package:cloutbook/config/palette.dart';
import 'package:cloutbook/screens/screens.dart';
import 'package:flutter/material.dart';

class NavScreen extends StatefulWidget {
  NavScreen({Key? key}) : super(key: key);

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final List<Widget> _screens = [
    HomeScreen(),
    ProfileScreen(),
    ExploreScreen(),
    SettingsScreen()
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.background,
      child: SafeArea(
        child: Scaffold(
          body: _screens[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Palette.foreground,
            currentIndex: _currentIndex,
            selectedItemColor: Palette.primary4,
            selectedFontSize: 11.0,
            unselectedIconTheme: const IconThemeData(color: Colors.white30),
            unselectedItemColor: Colors.white30,
            unselectedFontSize: 11.0,
            onTap: (index) => setState(() => _currentIndex = index),
            items: [
              BottomNavigationBarItem(
                icon: new Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.person),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.trending_up),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
