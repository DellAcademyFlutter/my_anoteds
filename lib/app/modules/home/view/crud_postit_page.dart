import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';

import 'package:my_anoteds/app/model/postit.dart';
import 'package:my_anoteds/app/model/postit_color.dart';
import 'package:my_anoteds/app/modules/home/home_controller.dart';
import 'package:my_anoteds/app/repositories/shared/Utils/image_picker_utils.dart';

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
  File image;
  String base64Image;

  @override
  void initState() {
    titleController.text = widget.postit != null ? widget.postit.title : "";
    descriptionController.text =
        widget.postit != null ? widget.postit.description : "";
    color = widget.postit != null ? widget.postit.color : "branco";
    title = titleController.text;
    description = descriptionController.text;

    if (widget.postit?.image != null) {
      base64Image = widget.postit.image;
    }

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
                  postit: widget.postit,
                  base64Image: base64Image,
                );
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
                        color: PostitColor.colors[color]['darkColor']
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
                  style: TextStyle(
                      color: PostitColor.colors[color]['darkColor']
                          ? Colors.white
                          : Colors.black),
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
              Container(
                color: Color(PostitColor.colors[color]['hex']),
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    widget.postit != null
                        ? Image.memory(
                            ImagePickerUtils.getBytesImage(
                                base64Image: base64Image),
                          )
                        : image == null
                            ? Text('Nenhuma imagem selecionada.')
                            : Image.file(
                                image,
                              ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RaisedButton(
                          child: Icon(Icons.camera_alt_outlined),
                          onPressed: () => ImagePickerUtils.getImageFile(
                                  imageSource: ImageSource.camera)
                              .then((value) {
                            setState(() {
                              image = value;
                              base64Image =
                                  ImagePickerUtils.getBase64ImageFromFileImage(
                                      pickedFile: value);
                            });
                          }),
                        ),
                        SizedBox(width: 20),
                        RaisedButton(
                          child: Icon(Icons.filter_outlined),
                          onPressed: () => ImagePickerUtils.getImageFile(
                                  imageSource: ImageSource.gallery)
                              .then((value) {
                            setState(() {
                              image = value;
                              base64Image =
                                  ImagePickerUtils.getBase64ImageFromFileImage(
                                      pickedFile: value);
                            });
                          }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children:
              PostitColor.colors.keys.map<IconButton>((String listItemValue) {
            return IconButton(
                icon: Icon(Icons.check_circle),
                color: Color(PostitColor.colors[listItemValue]['hex']),
                onPressed: () {
                  setState(() {
                    color = listItemValue;
                  });
                });
          }).toList(),
        ),
      ),
    );
  }
}
