import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/modules/home/model/postit.dart';
import 'package:my_anoteds/app/modules/home/model/postit_color.dart';
import 'package:my_anoteds/app/modules/home/model/user.dart';

class CrudPostitPage extends StatefulWidget {
  static const routeName = "/crudPostitPage";

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<CrudPostitPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String color = "branco";
  String title;
  String description;

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
                  savePostit(
                      title: title, description: description, color: color);
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
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Insira o Título do seu Postit',
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
                    labelText: 'Insira seu texto',
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

savePostit({String title, String description, String color}) {
  final user = Modular.get<User>();
  final postit = Postit(
      id: 0,
      title: title,
      description: description,
      color: color,
      user_id: 0,
      is_pinned: false);
  user.addPostit(postit: postit);
}
