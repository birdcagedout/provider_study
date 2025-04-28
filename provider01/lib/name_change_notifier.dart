import 'package:flutter/material.dart';


// step1. ChangeNotifier를 정의할 것
class NameChangeNotifier extends ChangeNotifier {
  String name;

  NameChangeNotifier({this.name = '이름 없음'});

  void changeName({required String newName}) async {
    name = newName;
    notifyListeners();  // listener들에게 변화를 알려준다
  }
}