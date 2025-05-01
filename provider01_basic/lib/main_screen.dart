import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'settings_screen.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  // body스크린 index
  int _screenIndex = 0;

  // body스크린
  final List<Widget> _screens = [
    HomeScreen(),
    SettingsScreen(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
        ],

        onTap: (value) => setState(() {
          _screenIndex = value;
        }),
      ),
    );
  }
}
