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
                  // step3. state의 변화를 감지해서 반영하는 부분
                  Text(context.watch<NameChangeNotifier>().name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
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
                  context.read<NameChangeNotifier>().changeName(newName: controller.text);
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
