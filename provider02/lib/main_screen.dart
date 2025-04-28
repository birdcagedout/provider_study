import 'package:flutter/material.dart';
import 'package:provider02/challenge_screen.dart';

import 'home_screen.dart';
import 'settings_screen.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  // 바디스크린 index
  int _screenIndex = 0;

  // 스크린
  final List<Widget> _screens = [
    HomeScreen(),
    SettingsScreen(),
    ChallengeScreen(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 화면 전환시 기존 화면이 보존되지 않는다
      // body: _screens[_screenIndex],

      // indexedStack으로 변경 ==> 기존 화면이 그대로 보존된다
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
          BottomNavigationBarItem(icon: Icon(Icons.settings, size: 35,),label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.explore, size: 35,),label: ''),
        ],

        onTap: (value) => setState(() {
          _screenIndex = value;
        }),
      ),
    );
  }
}
