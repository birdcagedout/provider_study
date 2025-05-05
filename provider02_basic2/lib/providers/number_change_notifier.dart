import 'package:flutter/material.dart';


// step1. ChangeNotifier를 정의할 것
class NumberChangeNotifier extends ChangeNotifier {
  int _num;

  NumberChangeNotifier({int num = 0}) : _num = num;

  int get num => _num;

  void incrementNumber() {
    _num++;
    notifyListeners();
  }

  void decrementNumber() {
    _num--;
    notifyListeners();
  }
}