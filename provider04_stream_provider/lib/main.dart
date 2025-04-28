// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



// StreamProvider 사용법
// 1. Stream<T>를 리턴하는 함수를 작성한다. ==> T는 어떤 타입(사용자정의타입 OK)이어도 좋다.
//    - 별도의 class를 정의할 필요가 없다.
//    - 별도로 class 안에서 notifyListeners() 호출할 필요가 없다. ==> Provider가 자동으로 해줌
// 2. 최상위 앱에 StreamProvider<T>를 래핑하고
//    - create에 아까 함수 리턴
//    - initialData 값 넣고(필수)
//    - child에 MaterialApp
// 3. state 값을 참조하려는 위젯의 build 함수 내에서 context.watch<T?>로 참조한다.
//    ==> 이때 반드시 T?로 참조해야 한다.(패키지 readme에 설명)
//    ==> Consumer나 Builder 내에서 참조하지 않는 이상 그 위젯 전체가 rebuild된다.



/// 1초마다 1씩 증가하는 카운터 스트림
Stream<int> counterStream() {
  return Stream.periodic(const Duration(seconds: 1), (count) => count + 1);
}


void main() {
  runApp(
    // StreamProvider로 스트림을 제공
    StreamProvider<int>(
      // create: 스트림 생성
      create: (_) => counterStream(),
      // 초기값은 0
      initialData: 0,
      child: const MaterialApp(
        home: StreamProviderExample(),
      ),
    ),
  );
}


class StreamProviderExample extends StatelessWidget {
  const StreamProviderExample({super.key});

  @override
  Widget build(BuildContext context) {
    // StreamProvider<int>에서 제공하는 값을 구독
    final counter = context.watch<int>();

    return Scaffold(
      appBar: AppBar(title: const Text('StreamProvider 예제')),
      body: Center(
        child: Text(
          '카운터: $counter',
          style: const TextStyle(fontSize: 32),
        ),
      ),
    );
  }
}
