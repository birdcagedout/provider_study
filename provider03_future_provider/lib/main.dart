// lib/main.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


// 실행 순서
// 앱 시작 시 fetchRandomNumber()가 호출되어 2초 대기
// 대기 중에는 randomNumber == null 이므로 로딩 인디케이터 표시
// Future 완료 후 notifyListeners() → 화면 리빌드
// 실제 난수 출력


// FutureProvider 사용법
// 1. Future<T>를 리턴하는 함수를 작성한다. ==> T는 어떤 타입(사용자정의타입 OK)이어도 좋다.
//    - 별도의 class를 정의할 필요가 없다.
//    - 별도로 class 안에서 notifyListeners() 호출할 필요가 없다. ==> Provider가 자동으로 해줌
// 2. 최상위 앱에 FutureProvider<T>를 래핑하고
//    - create에 아까 함수 리턴
//    - initialData 값 넣고(필수)
//    - child에 MaterialApp
// 3. state 값을 참조하려는 위젯의 build 함수 내에서 context.watch<T?>로 참조한다.
//    ==> 이때 반드시 T?로 참조해야 한다.(패키지 readme에 설명)
//    ==> Consumer나 Builder 내에서 참조하지 않는 이상 그 위젯 전체가 rebuild된다.




/// 임의의 난수를 2초 후에 반환하는 함수
Future<int> fetchRandomNumber() async {
  await Future.delayed(const Duration(seconds: 2));
  return Random().nextInt(100);
}


void main() {
  runApp(
    // FutureProvider로 비동기 결과를 제공
    FutureProvider<int?>(
      // create: 호출 시점에 Future 실행
      create: (context) => fetchRandomNumber(),
      // 대기 중 표시를 위해 초기값은 null
      initialData: null,
      child: const MaterialApp(
        home: FutureProviderExample(),
      ),
    ),
  );
}


class FutureProviderExample extends StatelessWidget {
  const FutureProviderExample({super.key});

  @override
  Widget build(BuildContext context) {
    // FutureProvider<int?>에서 제공하는 값을 구독
    final randomNumber = context.watch<int?>();

    return Scaffold(
      appBar: AppBar(title: const Text('FutureProvider 예제')),
      body: Center(
        child: randomNumber == null
              // Future가 완료되지 않았을 때 로딩 표시
            ? const CircularProgressIndicator()
              // 완료되면 결과 출력 (다시 보고 싶으면 Hot Restart)
            : Text('생성된 난수: $randomNumber', style: const TextStyle(fontSize: 24),),
      ),
    );
  }
}
