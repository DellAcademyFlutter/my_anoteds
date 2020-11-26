import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier{

  int count = 0;

  increment(){
    count++;

    notifyListeners();
  }

}