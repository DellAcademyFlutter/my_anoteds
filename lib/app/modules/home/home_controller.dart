import 'package:flutter/cupertino.dart';

class HomeController extends ChangeNotifier{
  int count = 0;

  increment(){
    count++;
    notifyListeners();
  }

  decrement(){
    count--;
    notifyListeners();
  }
}