import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/data/marking_dao.dart';
import 'package:my_anoteds/app/model/postit.dart';
import 'package:my_anoteds/app/model/postit_color.dart';
import 'package:my_anoteds/app/model/user.dart';
import 'package:my_anoteds/app/modules/home/components/crud_postit_settings_menu_widget.dart';
import 'package:my_anoteds/app/modules/home/components/crud_postit_select_image_menu_widget.dart';
import 'package:my_anoteds/app/modules/home/home_controller.dart';
import 'package:my_anoteds/app/modules/home/presenter/crud_postit_presenter.dart';
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

class _State extends State<CrudPostitPage> implements ICrudPostitController{
  final loggedUser = Modular.get<User>();
  final homeController = Modular.get<HomeController>();
  final markingDao = Modular.get<MarkingDao>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String color;
  String title;
  String description;
  File image;
  String base64Image;
  List<int> postitMarkers;
  CrudPostitPresenter controller;

  /// Atualizacao de estado da imagem inserida
  void callbackSetImageValue({@required File imageFile}) {
    setState(() {
      image = imageFile;
      base64Image =
          ImagePickerUtils.getBase64ImageFromFileImage(pickedFile: imageFile);
    });
  }

  /// Adiciona um index para os marcadores deste postit
  void callbackAddMarkerWithoutAtualize({@required int markerID}) {
    if (postitMarkers == null) {
      postitMarkers = List<int>();
    }
    if (!postitMarkers.contains(markerID)) {
      postitMarkers.add(markerID);
    }
  }

  List<int> callbackGetPostitMarkers() => postitMarkers;

  /// Adiciona um index para os marcadores deste postit
  void callbackAddMarker({@required int markerID}) {
    setState(() {
      if (!postitMarkers.contains(markerID)) {
        postitMarkers.add(markerID);
      }
    });
  }

  /// Remove um index dos marcadores deste postit
  void callbackRemoveMarker({@required int markerID}) {
    setState(() {
      if (postitMarkers.contains(markerID)) {
        postitMarkers.remove(markerID);
      }
    });
  }

  @override
  void update() {
    setState(() {});
  }

  @override
  void initState() {
    controller = CrudPostitPresenter(this);
    titleController.text = widget.postit != null ? widget.postit.title : "";
    descriptionController.text =
        widget.postit != null ? widget.postit.description : "";
    color = widget.postit != null ? widget.postit.color : "branco";
    title = titleController.text;
    description = descriptionController.text;
    postitMarkers = new List<int>();

    if (widget.postit?.image != null) {

      base64Image = widget.postit.image;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()=> controller.increment(),
      ),
      appBar: AppBar(
        title: Row(
          children: [
            Text('CRUD postit ${controller.counter}'),
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
                  postitMarkers: postitMarkers,
                );
                Modular.to.pop();
              },
            ),
          ],
        ),
        actions: [
          CrudPostitSettingsMenuWidget(
              callbackAddMarker: callbackAddMarker,
              callbackRemoveMarker: callbackRemoveMarker,
              priorAddedMarkers: postitMarkers),
        ],
      ),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              postitMarkersWidget(
                loggedUser: loggedUser,
                postit: widget.postit,
                callbackAddMarkerWithoutAtualize:
                    callbackAddMarkerWithoutAtualize,
                callbackGetPostitMarkers: callbackGetPostitMarkers,
              ),
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
                    widget.postit?.image != null
                        ? Image.memory(
                            ImagePickerUtils.getBytesImage(
                                base64Image: base64Image),
                          )
                        : image == null
                            ? Text('Nenhuma imagem selecionada.')
                            : Image.file(
                                image,
                              ),
                  ],
                ),
              ),
            ],
          )),
      bottomNavigationBar: BottomAppBar(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CrudPostitSelectImageMenuWidget(callbackSetImageValue),
              Row(
                children: PostitColor.colors.keys
                    .map<IconButton>((String listItemValue) {
                  return IconButton(
                      icon: Icon(Icons.circle),
                      color: Color(PostitColor.colors[listItemValue]['hex']),
                      onPressed: () {
                        setState(() {
                          color = listItemValue;
                        });
                      });
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

class postitMarkersWidget extends StatelessWidget {
  postitMarkersWidget(
      {this.loggedUser,
      this.postit,
      this.callbackAddMarkerWithoutAtualize,
      this.callbackGetPostitMarkers});

  final User loggedUser;
  final Postit postit;
  final Function callbackAddMarkerWithoutAtualize;
  final Function callbackGetPostitMarkers;
  final markingDao = Modular.get<MarkingDao>();

  @override
  Widget build(BuildContext context) {

    return postit != null
        ? FutureBuilder(
            future: markingDao.getPostitMarkersIds(
                userId: loggedUser.id, postitId: postit.id),
            builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
              if (snapshot.hasData) {
                for (var i = 0; i < snapshot.data.length; i++) {
                  callbackAddMarkerWithoutAtualize(markerID: snapshot.data[i]);
                }
              }
              return snapshot.hasData
                  ? Container(
                      child: Row(
                        children: callbackGetPostitMarkers()
                            .map<Card>((int markerId) {
                          return Card(
                              margin: EdgeInsets.all(8),
                              child: Text(loggedUser.getMarkerTitleById(
                                  markerId: markerId)));
                        }).toList(),
                      ),
                    )
                  : Container(child: Row(
                    children: [
                      CircularProgressIndicator(),
                      Text("Carregando..."),
                    ],
                  ));
            })
        : SizedBox.shrink();
  }
}
