import 'package:cloutbook/config/palette.dart';
import 'package:cloutbook/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';

import '../stores/ProfileStore.dart';

class NavScreen extends HookWidget {
  final ProfileStore _profileStore = GetIt.I<ProfileStore>();
  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      HomeScreen(),
      ProfileScreen(
        username: _profileStore.loggedInProfile,
      ),
      ExploreScreen(),
      SettingsScreen()
    ];
    final _currentIndex = useState(0);
    return Container(
      color: Palette.background,
      child: SafeArea(
        child: Scaffold(
          body: _screens[_currentIndex.value],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Palette.foreground,
            currentIndex: _currentIndex.value,
            selectedItemColor: Palette.primary4,
            selectedFontSize: 11.0,
            unselectedIconTheme: const IconThemeData(color: Colors.white30),
            unselectedItemColor: Colors.white30,
            unselectedFontSize: 11.0,
            onTap: (index) => _currentIndex.value = index,
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
