import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'name_change_notifier.dart';


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}


class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // step3. 보통 build의 첫머리에서 state의 값을 받는다.
    //        즉, state의 변화를 계속 watch(=listen)하다가 notifyListeners()가 호출되면 변화된 값을 받아내고, UI에 반영한다.
    //        ==> 이때 context.watch<T>()를 호출한 위젯의 build()가 자동으로 실행된다. ==> 새로운 state값을 currentName에서 받는다.
    final notifier = context.read<NameChangeNotifier>();
    // final currentName = notifier.name;                           // **(주의)** 이런 식으로 read의 결과로 받은 notifier를 사용해서 state값을 읽으면 안 된다.
    final currentName = context.watch<NameChangeNotifier>().name;   // 계속적 watch의 결과로 받은 notifier를 사용해야 state값을 제대로 감지할 수 있다.

    return Scaffold(
      appBar: AppBar(title: const Text('Settings'),),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 현재 이름: 이름 없음
              Row(
                children: [
                  Text('Current name:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  // 3-1. UI에 반영한다.
                  Text(currentName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                ],
              ),
        
              // 이름 쓰기
              TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
        
              // 버튼
              ElevatedButton(
                onPressed: () {
                  // step4. state의 값을 적극적으로 변화시키는 부분
                  notifier.changeName(newName: controller.text);
                  FocusManager.instance.primaryFocus?.unfocus();
                  controller.clear();
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
