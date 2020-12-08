import 'package:flutter/material.dart';
import 'package:my_anoteds/app/controller/postit_controller.dart';
import 'package:my_anoteds/app/model/postit.dart';
import 'package:my_anoteds/app/model/postit_color.dart';

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
        backgroundColor: Colors.amber,
        title: Row(
          children: [
            Text('Postit', style: TextStyle(color: Colors.black)),
            Spacer(),
            IconButton(
              icon: Icon(Icons.check, color: Colors.black),
              tooltip: 'Salvar',
              onPressed: () {
                PostitController.savePostit(
                    title: title,
                    description: description,
                    color: color,
                    postit: widget.postit);
                Navigator.of(context).pop();
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
                  style: (color == "verde" || color == "azul")
                      ? TextStyle(color: Colors.white)
                      : TextStyle(color: Colors.black),
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
                color: Color(PostitColor.colors[color]),
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
                        color: (color == "verde" || color == "azul")
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    labelText: 'Insira seu texto',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: (color == "verde" || color == "azul")
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
              ),
            ],
          )),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Colors.black54,
          child: Row(
            children: [
              IconButton(
                  icon: Icon(Icons.adjust),
                  color: Color(PostitColor.colors["branco"]),
                  onPressed: () {
                    setState(() {
                      color = "branco";
                    });
                  }),
              IconButton(
                  icon: Icon(Icons.adjust),
                  color: Color(PostitColor.colors["amarelo"]),
                  onPressed: () {
                    setState(() {
                      color = "amarelo";
                    });
                  }),
              IconButton(
                  icon: Icon(Icons.adjust),
                  color: Color(PostitColor.colors["roso"]),
                  onPressed: () {
                    setState(() {
                      color = "roso";
                    });
                  }),
              IconButton(
                  icon: Icon(Icons.adjust),
                  color: Color(PostitColor.colors["verde"]),
                  onPressed: () {
                    setState(() {
                      color = "verde";
                    });
                  }),
              IconButton(
                  icon: Icon(Icons.adjust),
                  color: Color(PostitColor.colors["lavanda"]),
                  onPressed: () {
                    setState(() {
                      color = "lavanda";
                    });
                  }),
              IconButton(
                  icon: Icon(Icons.adjust),
                  color: Color(PostitColor.colors["azul"]),
                  onPressed: () {
                    setState(() {
                      color = "azul";
                    });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
