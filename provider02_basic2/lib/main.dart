import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/number_change_notifier.dart';
import 'providers/name_change_notifier.dart';
import 'navigation.dart';


// Youtube Provider Tutorial by FlutterMapp
// https://www.youtube.com/watch?v=FUDhozpnTUw

/* 핵심: ChangeNotifier + Provider가 가장 일반적인 조합
1. Notifier 정의
  - extends ChangeNotifier
  - 내부 데이터가 state 역할
  - notifyListeners() 메소드로 state변화를 Listener에게 알림

2. MultiProvider 정의
  - 사용자의 최상위 앱(MaterialApp보다 상위)에서 MultiProvider를 리턴한다. MyApp - MultiProvider - MaterialApp 순서
  - providers 인자에 List로 "아까 정의한 ChangeNotifier"를 리턴하는 ChangeNotifierProvider 개체를 생성

3. .watch() : listen to changes (계속적)
  - ChangeNotifier 내부의 state 변화가 있으면 notifyListeners() 호출하는데, 이때 .watch가 변화를 감지하여 반영한다.
  - ** 수동적으로 값을 읽어오는 역할 **
  - 본질적으로는 provider의 내부 notifier 인스턴스가 리턴된다.

4. .read() : dont listen to changes (1회성)
  - state의 값 또는 ** Notifier 그 자체 **를 읽어온다.
  - 평소에 state의 변화를 listen하고 있지 않다.
  - ** 적극적으로 값의 변화를 일으킬 때 필요 **
  - 본질적으로는 provider의 내부 notifier 인스턴스가 리턴된다.
*/


void main() {
  runApp(const MyApp());
}


// 사용자 최상위 앱
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // step2. 최상위 앱에서 MultiProvider를 리턴한다.
    return MultiProvider(
      providers: [
        // 2-1. 개별적인 Provider 생성 ==> 아까 만든 ChangeNotifier를 리턴
        ChangeNotifierProvider(create: (context) => NameChangeNotifier(),),

        // 2-2. Challenge
        ChangeNotifierProvider(create: (context) => NumberChangeNotifier(),),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.teal,),
        home: Navigation(),
      ),
    );
  }
}
