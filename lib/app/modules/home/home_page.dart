import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/modules/home/home_controller.dart';
import 'package:my_anoteds/app/modules/home/postit_model.dart';
import 'package:my_anoteds/app/repositories/local/database/db_helper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Modular.get<HomeController>();
  final dbHelper = DbHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: FutureBuilder(
          future: dbHelper.getContacts(),
          builder: (BuildContext context, AsyncSnapshot<List<PostitModel>> snapshot) {
            final list = snapshot.data;

            return snapshot.hasData ? ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {

                return Text(list[index].title ?? "este item é nulo");
              },
            ) : CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          dbHelper.create(PostitModel(
            title: "Trabalho de matematica",
            desc: "Pagina 30, 31.",
            tag: "faculdade"
          ));

          setState(() {

          });
        },
      ),
    );
  }
}
