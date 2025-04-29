import 'package:flutter/material.dart';

// Home화면에서는 name을 표시만 하면 되므로 StatelessWidget
// => 생성자 파라미터로 넘겨받은 name을 바로 표시

class HomeScreen extends StatelessWidget {
  final String name;
  const HomeScreen({super.key, required this.name});

  // Settings화면에서 Save버튼 누르면
  // MainScreen의 didUpdateWidget()이 호출된 후 build()가 호출된다.
  // => HomeScreen의 인자값이 달라졌으므로 Stateless위젯인 HomeScreen은 rebuild된다.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Text(
          name,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
