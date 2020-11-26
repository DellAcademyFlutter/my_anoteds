import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/modules/home/home_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Modular.get<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Consumer<HomeController>(
              builder: (context, value) {
                return Text("${value.count}");
              }
            ),
            RaisedButton(
              child: Text("Add"),
              onPressed: ()=> controller.increment(),
            )
          ],
        ),
      ),
    );
  }
}
