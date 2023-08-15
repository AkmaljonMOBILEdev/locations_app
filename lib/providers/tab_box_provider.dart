import 'package:flutter/material.dart';

class TabBoxProvider with ChangeNotifier{
  int index = 0;

  changeIndex(int value){
    index = value;
    notifyListeners();
  }
}