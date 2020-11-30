import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/modules/home/home_controller.dart';
import 'package:my_anoteds/app/modules/home/home_page2.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Modular.get<HomeController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("HomePage1"),
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
                  child: Text("Add ++ "),
                  onPressed: () {
                    setState(() {
                      controller.increment();
                    });
                  },
                ),
                RaisedButton(
                  child: Text("Jump page 2"),
                  onPressed: () {
                    Modular.to.pushNamed('/page2', arguments: HomePage2Arguments(arg1: controller.count));
                  },
                ),
                RaisedButton(
                  child: Text("Jump page 3"),
                  onPressed: () {
                    Modular.to.pushNamed('/page3');
                  },
                ),
              ],
            )),
      ),
    );
  }
}
