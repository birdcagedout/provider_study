import 'package:flutter/material.dart';


// step1. ChangeNotifier를 정의할 것
class NameChangeNotifier extends ChangeNotifier {
  String _name;

  NameChangeNotifier({String name = '이름 없음'}) : _name = name;

  String get name => _name;

  void changeName({required String newName}) {
    if(newName == _name) return;

    _name = newName;
    notifyListeners();  // listener들에게 변화를 알려준다
  }
}