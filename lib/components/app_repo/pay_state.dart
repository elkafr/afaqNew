import 'package:flutter/material.dart';

class PayState extends ChangeNotifier {
  int _initialIndex = 0;

  void upadateInitialIndex(int value) {
    _initialIndex = value;
    notifyListeners();
  }

  int get initialIndex => _initialIndex;
}
