import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'name_change_notifier.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home'),),
      body: Center(
        child: Text(
          // step3. 변화를 계속 listen하도록 warch하다가 notify가 오면 변화된 값을 반영한다.
          context.watch<NameChangeNotifier>().name,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
