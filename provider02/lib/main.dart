import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider02/number_change_notifier.dart';

import 'name_change_notifier.dart';
import 'main_screen.dart';

// Youtube Provider Tutorial
// https://www.youtube.com/watch?v=FUDhozpnTUw

/*
1. Notifier 정의
- extends ChangeNotifier
- 내부 데이터가 state 역할
- notifyListeners() 메소드로 state변화를 알림

2. MultiProvider 정의
- 최상위(MaterialApp보다 상위) 앱에서 MultiProvider를 리턴
- providers 인자에 List로 "아까 정의한 ChangeNotifier"를 리턴하는 ChangeNotifierProvider 개체를 생성

3. .watch() : listen to changes (계속적)
- ChangeNotifier에서 state변화가 있으면 notifyListeners()하게되는데, 이때 .watch가 변화를 감지하여 반영한다.
- ** 수동적으로 값을 읽어오는 역할 **

4. .read() : dont listen to changes (1회성)
- state의 값(또는 Notifier 그 자체)을 읽어온다.
- 평소에 state의 변화를 listen하고 있지 않다.
- ** 적극적으로 값의 변화를 일으키는 역할 **
*/

void main() {
  runApp(const MyApp());
}

// 최상위 앱
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // step2. 최상위 앱에서 MultiProvider를 리턴할 것
    return MultiProvider(
      providers: [
        // 2-1. 개별적인 Provider 생성 ==> 아까 만든 ChangeNotifier를 리턴
        ChangeNotifierProvider(create: (context) => NameChangeNotifier(),),

        // Challenge
        ChangeNotifierProvider(create: (context) => NumberChangeNotifier(),),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.teal,),
        home: MainScreen(),
      ),
    );
  }
}
