import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
//import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:my_anoteds/app/app_module.dart';

void main() {
  //Stetho.initialize();
  runApp(ModularApp(module: AppModule()));
}