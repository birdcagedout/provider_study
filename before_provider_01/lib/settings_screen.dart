import 'package:flutter/material.dart';

// Settings화면도 값을 저장해야 하므로 StatefulWidget
// - currentName과 onNameChanged 콜백을 생성자로 받음
// - TextFormField 초기값을 currentName으로 세팅
// - 버튼을 누르면 onNameChanged(controller.text) 호출

class SettingsScreen extends StatefulWidget {
  final String currentName;
  final ValueChanged<String> onNameChanged;

  const SettingsScreen({
    super.key,
    required this.currentName,
    required this.onNameChanged,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    // 폼필드에 초기값 설정
    _controller = TextEditingController(text: widget.currentName);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  // 넘겨받은 상태값을 출력
                  Text(
                    widget.currentName,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // 넘겨받은 콜백을 호출
                  widget.onNameChanged(_controller.text);
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
