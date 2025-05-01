import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'name_change_notifier.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // step3. 보통 build의 첫머리에서 state의 값을 받는다.
    //        즉, state의 변화를 계속 watch(=listen)하다가 notifyListeners()가 호출되면 변화된 값을 받아내고, UI에 반영한다.
    //        ==> 이때 context.watch<T>()를 호출한 위젯의 build()가 자동으로 실행된다. ==> 새로운 state값을 currentName에서 받는다.
    final currentName = context.watch<NameChangeNotifier>().name;

    return Scaffold(
      appBar: AppBar(title: const Text('Home'),),
      body: Center(
        child: Text(
          currentName,  // 3-1. UI에 반영한다.
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
