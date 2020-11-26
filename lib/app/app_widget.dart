import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/app_controller.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Anoteds",
      initialRoute: '/',
      navigatorKey: Modular.navigatorKey,
      onGenerateRoute: Modular.generateRoute,
    );
  }
}