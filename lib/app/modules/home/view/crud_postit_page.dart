import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:my_anoteds/app/model/postit.dart';
import 'package:my_anoteds/app/model/postit_color.dart';
import 'package:my_anoteds/app/modules/home/home_controller.dart';

class CrudPostitPageArguments {
  CrudPostitPageArguments({this.postit});
  Postit postit;
}

class CrudPostitPage extends StatefulWidget {
  CrudPostitPage({this.postit});

  static const routeName = "/crudPostitPage";
  final Postit postit;

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<CrudPostitPage> {
  final homeController = Modular.get<HomeController>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String color;
  String title;
  String description;

  @override
  void initState() {
    titleController.text = widget.postit != null ? widget.postit.title : "";
    descriptionController.text =
    widget.postit != null ? widget.postit.description : "";
    color = widget.postit != null ? widget.postit.color : "branco";
    title = titleController.text;
    description = descriptionController.text;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('CRUD postit'),
            Spacer(),
            IconButton(
              icon: Icon(Icons.save),
              tooltip: 'Salvar postit',
              onPressed: () {
                homeController.savePostit(
                    title: title,
                    description: description,
                    color: color,
                    postit: widget.postit);
                Modular.to.pop();
              },
            ),
          ],
        ),
      ),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                color: Color(PostitColor.colors[color]),
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: titleController,
                  maxLines: null, // Necessario para entrada multilinha
                  keyboardType: TextInputType.multiline,
                  onChanged: (valor) => setState(() => title = valor),
                  style: TextStyle(fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Título',
                  ),
                ),
              ),
              Container(
                color: Color(PostitColor.colors[color]),
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextFormField(
                  controller: descriptionController,
                  maxLines: 20,
                  onChanged: (valor) => setState(() => description = valor),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Descrição',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
              ),
            ],
          )),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            IconButton(
                icon: Icon(Icons.check_circle),
                color: Color(PostitColor.colors["branco"]),
                onPressed: () {
                  setState(() {
                    color = "branco";
                  });
                }),
            IconButton(
                icon: Icon(Icons.check_circle),
                color: Color(PostitColor.colors["amarelo"]),
                onPressed: () {
                  setState(() {
                    color = "amarelo";
                  });
                }),
            IconButton(
                icon: Icon(Icons.check_circle),
                color: Color(PostitColor.colors["roso"]),
                onPressed: () {
                  setState(() {
                    color = "roso";
                  });
                }),
            IconButton(
                icon: Icon(Icons.check_circle),
                color: Color(PostitColor.colors["verde"]),
                onPressed: () {
                  setState(() {
                    color = "verde";
                  });
                }),
            IconButton(
                icon: Icon(Icons.check_circle),
                color: Color(PostitColor.colors["lavanda"]),
                onPressed: () {
                  setState(() {
                    color = "lavanda";
                  });
                }),
            IconButton(
                icon: Icon(Icons.check_circle),
                color: Color(PostitColor.colors["azul"]),
                onPressed: () {
                  setState(() {
                    color = "azul";
                  });
                }),
          ],
        ),
      ),
    );
  }
}


