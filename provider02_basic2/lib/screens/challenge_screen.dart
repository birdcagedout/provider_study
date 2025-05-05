import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/number_change_notifier.dart';


class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({super.key});

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}


class _ChallengeScreenState extends State<ChallengeScreen> {

  @override
  Widget build(BuildContext context) {
    // step3. 보통 build의 첫머리에서 state의 값을 받는다.
    //        즉, state의 변화를 계속 watch(=listen)하다가 notifyListeners()가 호출되면 변화된 값을 받아내고, UI에 반영한다.
    //        ==> 이때 "context.watch<T>()를 호출한 위젯의 build()"가 자동으로 실행된다. ==> 새로운 state값을 currentName에서 받는다.
    final notifier = context.read<NumberChangeNotifier>();            // notifier를 받아온다.
    // final currentNumber = notifier.num;                            // **(주의)** 이런 식으로 read의 결과로 받은 notifier를 사용해서 state값을 읽으면 안 된다.
    final currentNumber = context.watch<NumberChangeNotifier>().num;  // 계속적 watch의 결과로 받은 notifier를 사용해야 state값을 제대로 감지할 수 있다.

    return Scaffold(
      appBar: AppBar(title: Text('Challenge'),),
      body: Center(
        child: Text(
          currentNumber.toString(),
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),

      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,   // 우측하단에 위치시키는 핵심!
        children: [
          FloatingActionButton(
            backgroundColor: Colors.teal[200],
            foregroundColor: Colors.white,
            onPressed: () {
              notifier.incrementNumber();
            },
            child: Icon(Icons.add, size: 30,),
          ),
          SizedBox(height: 20,),
          FloatingActionButton(
            backgroundColor: Colors.teal[200],
            foregroundColor: Colors.white,
            onPressed: () {
              notifier.decrementNumber();
            },
            child: Icon(Icons.remove, size: 30,),
          ),
        ],
      ),
    );
  }
}
