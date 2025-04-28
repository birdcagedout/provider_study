import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


// 어떤 종류의 사용자 정의 타입도 가능
class User {
  final String id;
  final String name;
  final int age;

  User({required this.id, required this.name, required this.age});
}




// 1) 비동기로 User 객체를 가져오는 함수
Future<User> fetchUser() async {
  await Future.delayed(const Duration(seconds: 3));
  return User(id: 'u123', name: '홍길동', age: 42);
}

// 2) 앱 진입점에 FutureProvider<User> 등록
void main() {
  runApp(
    FutureProvider<User?>(
      create: (_) => fetchUser(),
      initialData: null,
      catchError: (_, __) => null,
      child: const MaterialApp(home: UserScreen()),
    ),
  );
}

// 3) 사용처
class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();

    if (user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('사용자 정보')),
      body: Center(
        child: Text(
          'ID: ${user.id}\n이름: ${user.name}\n나이: ${user.age}',
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
