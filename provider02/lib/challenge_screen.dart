import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'number_change_notifier.dart';

class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({super.key});

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Challenge'),),
      body: Center(
        child: Text(
          context.watch<NumberChangeNotifier>().num.toString(),
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.teal[200],
            foregroundColor: Colors.white,
            onPressed: () {
              context.read<NumberChangeNotifier>().incrementNumber();
            },
            child: Icon(Icons.add, size: 30,),
          ),
          SizedBox(height: 20,),
          FloatingActionButton(
            backgroundColor: Colors.teal[200],
            foregroundColor: Colors.white,
            onPressed: () {
              context.read<NumberChangeNotifier>().decrementNumber();
            },
            child: Icon(Icons.remove, size: 30,),
          ),
        ],
      ),
    );
  }
}
