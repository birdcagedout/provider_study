import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'settings_screen.dart';

// 2. Main화면에서도 값을 넘겨받아 저장하고 있어야 하므로 StatefulWidget
//    => 넘겨받은 상태값을 변수로 저장하고 있다가
//    => 자식인 Home화면과 Settings화면에 값을 넘겨준다.

class MainScreen extends StatefulWidget {
  final String name;
  final ValueChanged<String> onNameChanged;

  const MainScreen({
    super.key,
    required this.name,
    required this.onNameChanged,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}



class _MainScreenState extends State<MainScreen> {
  int _screenIndex = 0;

  // Settings화면에서 Save버튼 누르면
  // MainScreen 생성자의 인자값이 달라지므로
  // MainScreen의 didUpdateWidget()이 호출된 후 build()가 호출된다.
  @override
  void didUpdateWidget(covariant MainScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('[MainScreen] 이전값: ${oldWidget.name}  현재값: ${widget.name}');
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      // 각 자식 화면에 상태값을 넘겨준다
      HomeScreen(name: widget.name),
      SettingsScreen(
        currentName: widget.name,
        onNameChanged: widget.onNameChanged,
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _screenIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _screenIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 35), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings, size: 35), label: ''),
        ],
        onTap: (idx) => setState(() {
          _screenIndex = idx;
        }),
      ),
    );
  }
}
