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
  late final NameChangeNotifier _notifier;
  late final TextEditingController _controller;
  bool _initialized = false;  // didChangeDependencies가 여러 번 호출되기 때문에 플래그 사용

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // print("didChangeDependencies 호출됨");

    // 7-2. 초기화 시에 notifier 받아옴
    //      (1) context.dependOnInheritedWidgetOfExactType() → _dependents 집합에 등록
    //      (2) Provider의 Element(=InheritedNotifierElement) 내부에서 notifier.addListener(...) 호출
    //      ==> (1) + (2) 과정을 끝낸 후 Provider 내부의 notifier(=NameChangeNotifier) 리턴
    //
    // **주의** 이 부분을 initState() 내부에서 실행하면 ==> Exception 발생
    // ======== Exception caught by widgets library =======================================================
    // The following assertion was thrown building _VisibilityScope:
    // dependOnInheritedWidgetOfExactType<NameNotifierProvider>() or dependOnInheritedElement() was called
    // before _SettingsScreenState.initState() completed.
    //
    // When an inherited widget changes, for example if the value of Theme.of() changes, its dependent widgets are rebuilt.
    // If the dependent widget's reference to the inherited widget is in a constructor or an initState() method,
    // then the rebuilt dependent widget will not reflect the changes in the inherited widget.
    //
    // Typically references to inherited widgets should occur in widget build() methods.
    // Alternatively, initialization based on inherited widgets can be placed in the didChangeDependencies method,
    // which is called after initState and whenever the dependencies change thereafter.
    if (!_initialized) {
      _notifier = NameNotifierProvider.of(context);
      _controller = TextEditingController(text: _notifier.name,);
      _initialized = true;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
