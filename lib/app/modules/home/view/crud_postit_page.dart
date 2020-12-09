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
                color: Color(PostitColor.colors[color]['hex']),
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: titleController,
                  maxLines: null, // Necessario para entrada multilinha
                  keyboardType: TextInputType.multiline,
                  style: TextStyle(
                      color: PostitColor.colors[color]['darkColor']
                          ? Colors.white
                          : Colors.black),
                  onChanged: (valor) => setState(() => title = valor),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Insira o Título do seu Postit',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: (color == "verde" || color == "azul")
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
              ),
              Container(
                color: Color(PostitColor.colors[color]['hex']),
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextFormField(
                  controller: descriptionController,
                  maxLines: 20,
                  cursorColor: Colors.black,
                  style: (color == "verde" || color == "azul")
                      ? TextStyle(color: Colors.white)
                      : TextStyle(color: Colors.black),
                  onChanged: (valor) => setState(() => description = valor),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: PostitColor.colors[color]['darkColor']
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    labelText: 'Insira seu texto',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: PostitColor.colors[color]['darkColor']
                            ? Colors.white
                            : Colors.black),
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
                color: Color(PostitColor.colors["branco"]['hex']),
                onPressed: () {
                  setState(() {
                    color = "branco";
                  });
                }),
            IconButton(
                icon: Icon(Icons.check_circle),
                color: Color(PostitColor.colors["amarelo"]['hex']),
                onPressed: () {
                  setState(() {
                    color = "amarelo";
                  });
                }),
            IconButton(
                icon: Icon(Icons.check_circle),
                color: Color(PostitColor.colors["roso"]['hex']),
                onPressed: () {
                  setState(() {
                    color = "roso";
                  });
                }),
            IconButton(
                icon: Icon(Icons.check_circle),
                color: Color(PostitColor.colors["verde"]['hex']),
                onPressed: () {
                  setState(() {
                    color = "verde";
                  });
                }),
            IconButton(
                icon: Icon(Icons.check_circle),
                color: Color(PostitColor.colors["lavanda"]['hex']),
                onPressed: () {
                  setState(() {
                    color = "lavanda";
                  });
                }),
            IconButton(
                icon: Icon(Icons.check_circle),
                color: Color(PostitColor.colors["azul"]['hex']),
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
