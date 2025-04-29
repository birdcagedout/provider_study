import 'package:flutter/material.dart';
import 'main_screen.dart';


// Provider 패키지를 사용하지 않은 경우의 구현 #01
//
// 1. 최상위 앱(MyApp)에서 상태를 저장하고 있어야 하므로 StatefulWidget
//    - _name 상태와 _changeName 콜백을 정의
//    - MaterialApp의 home에 MainScreen(name:…, onNameChanged:…)으로 상태값을 넘겨줌
//      ==> 실제 값을 사용하는 직계후손 위젯까지 계속 생성자로 값을 넘겨주어야 한다.

void main() {
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  // 실질적인 상태값
  String _name = '이름 없음';

  void _changeName(String newName) {
    setState(() {
      _name = newName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.teal),
      // 상태값을 인자로 넘겨줌
      home: MainScreen(
        name: _name,
        onNameChanged: _changeName,
      ),
    );
  }
}
