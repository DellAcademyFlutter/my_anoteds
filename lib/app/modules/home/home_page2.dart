import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/modules/home/home_controller.dart';

class HomePage2Arguments{
  int arg1;
  HomePage2Arguments({this.arg1});
}

class HomePage2 extends StatefulWidget {
  HomePage2({this.arg1});
  final int arg1;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage2> {
  final controller = Modular.get<HomeController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("HomePage2"),
          centerTitle: true,
        ),
        body: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Consumer(builder: (context, value) {
                  return Text("${controller.count}");
                }),
                RaisedButton(
                  child: Text("Decrement -- "),
                  onPressed: () {
                    setState(() {
                      controller.decrement();
                    });
                  },
                ),
                Text("Argumento passado: ${widget.arg1}"),
              ],
            )),
      ),
    );
  }
}
