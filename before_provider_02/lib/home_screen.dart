import 'package:flutter/material.dart';
import 'notifier_provider.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 6. Provider(NameChangeNotifier)에 의존성 등록(dependOnInheritedWidgetOfExactType)
    //    + 내부 notifier(=NameChangeNotifier) 리턴받기
    //    + (내부 notifier의) name 속성 가져오기
    final name = NameNotifierProvider.of(context).name;

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Text(
          name,       // name값 변경 -> notifyListeners() -> rebuild -> 새로운 name값 -> Text에 반영
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
