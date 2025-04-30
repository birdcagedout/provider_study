import 'package:flutter/material.dart';

import 'notifier_provider.dart';


// 6. state값의 변화를 반영할 위젯을 Stateful로 선언
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}


class _SettingsScreenState extends State<SettingsScreen> {

  // 7-1. State 내부에 Notifier 변수 선언
  //      => Provider.of(context)로 리턴받은 notifier를 저장해놔야, 나중에 notifier의 내부 속성/메소드에 접근 가능
  // late final NameChangeNotifier _notifier;
  final TextEditingController _controller = TextEditingController();

  /*
  @override
  void initState() {
    super.initState();

    // 이 방법은 실패
    //======== Exception caught by widgets library =======================================================
    // The following LateError was thrown building SettingsScreen(dirty, state: _SettingsScreenState#89888):
    // LateInitializationError: Field '_notifier@721195070' has not been initialized.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _notifier = NameNotifierProvider.of(context);
      _controller = TextEditingController(text: _notifier.name,);
    },);

    // 이 방법도 실패
    // ======== Exception caught by widgets library =======================================================
    // The following LateError was thrown building SettingsScreen(dirty, state: _SettingsScreenState#c95bf):
    // LateInitializationError: Field '_notifier@721195070' has not been initialized.
    Future.delayed(Duration.zero).then((value) {
      _notifier = NameNotifierProvider.of(context);
      _controller = TextEditingController(text: _notifier.name,);
    },);
  }
  */

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 7. build 내부에 Notifier 변수 선언
    //    => Provider.of(context)로 리턴받은 notifier를 저장해놔야, 나중에 notifier의 내부 속성/메소드에 접근 가능
    final NameChangeNotifier _notifier = NameChangeNotifierProvider.of(context);

    // 8. Notifier의 값(state)을 참조하는 부분을 build()의 첫부분에 두어야 한다.
    //    ==> 그래야 매 빌드마다 최신 name을 읽어서 화면에 반영할 수 있다.
    final currentName = _notifier.name;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Current name:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    // 9. currentName 변경 -> notifyListeners() -> _SettingsScreenState이 rebuild -> 새로운 currentName -> 반영
                    currentName,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _controller,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                onTap: () {_controller.clear();},
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // 10. Notifier 인스턴스의 changeName 메소드 직접 호출 -> notifyListeners() -> 리스너들의 build 재호출
                  _notifier.changeName(_controller.text);
                  FocusManager.instance.primaryFocus?.unfocus();
                  _controller.clear();
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
