import 'package:flutter/material.dart';

class PageTest extends StatefulWidget {
  static const routeName = "/pageTest";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<PageTest> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("teste"),
          centerTitle: true,
        ),
        body: Text('Text'),
      ),
    );
  }
}