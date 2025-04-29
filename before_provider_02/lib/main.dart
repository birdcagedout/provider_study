import 'package:flutter/material.dart';

import 'notifier_provider.dart';
import 'main_screen.dart';


void main() {
  runApp(const MyApp());
}

// 3. 사용자 위젯 중 최상위 위젯을 StatefulWidget으로 선언하고
class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  // 4-1. State 내부에 Notifier 인스턴스 생성
  final NameChangeNotifier _notifier = NameChangeNotifier();

  @override
  void dispose() {
    // 4-2. notifier는 나중에 제거해준다.
    _notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 5. 사용자 최상위 위젯의 build에서 Provider를 리턴하는 구조로 만든다.
    //    + Provider의 child에 MaterialApp을 둔다.
    return NameNotifierProvider(
      notifier: _notifier,
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.teal),
        home: const MainScreen(),
      ),
    );
  }
}
