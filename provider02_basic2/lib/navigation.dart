import 'package:flutter/material.dart';

import 'screens/challenge_screen.dart';
import 'screens/home_screen.dart';
import 'screens/settings_screen.dart';


class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}


class _NavigationState extends State<Navigation> {

  // 바디스크린 index
  int _screenIndex = 0;

  // 바디스크린
  final List<Widget> _screens = [
    HomeScreen(),
    SettingsScreen(),
    ChallengeScreen(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // (주의) 이렇게 구성하면 화면 전환시 기존 화면이 보존되지 않는다
      // body: _screens[_screenIndex],

      // (중요) indexedStack으로 구성 ==> 화면 전환시 기존 화면이 그대로 보존된다
      body: IndexedStack(
        index: _screenIndex,
        children: _screens,
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _screenIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 35,), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings, size: 35,), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.explore, size: 35,), label: ''),
        ],

        onTap: (idx) => setState(() {
          _screenIndex = idx;
        }),
      ),
    );
  }
}
