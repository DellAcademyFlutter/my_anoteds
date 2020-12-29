import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/app_controller.dart';
import 'package:my_anoteds/app/data/marker_dao.dart';

import 'crud_marker_controller.dart';

class CrudMarkerPage extends StatefulWidget {
  static const routeName = "/CrudMarkerPage";
  CrudMarkerPage();

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<CrudMarkerPage> {
  TextEditingController markertitle = TextEditingController();
  final appController = Modular.get<AppController>();
  final crudMarkerController = Modular.get<CrudMarkerController>();
  final markerDao = Modular.get<MarkerDao>();
  String title;

  @override
  void initState() {
    super.initState();

    crudMarkerController.initializeUserMarkers(
        loggedUser: appController.loggedUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar marcador'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ListTile(
              leading: Icon(Icons.bookmarks_sharp),
              title: TextFormField(
                controller: markertitle,
                maxLines: 1,
                cursorColor: Colors.black,
                onChanged: (valor) => setState(() => title = valor),
                decoration: InputDecoration(
                  labelText: 'Insira o título do marcador',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  crudMarkerController.saveMarker(
                      title: title, userId: appController.loggedUser.id);
                },
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: SizedBox(
                height: 200,
                child: Consumer<AppController>(builder: (context, value) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: appController.markers.length,
                    itemBuilder: (BuildContext context, int index) =>
                        CrudMarkerWidget(
                      index: index,
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CrudMarkerWidget extends StatefulWidget {
  CrudMarkerWidget({this.index});
  final int index;

  @override
  _CrudMarkerWidgetState createState() => _CrudMarkerWidgetState();
}

class _CrudMarkerWidgetState extends State<CrudMarkerWidget> {
  final appController = Modular.get<AppController>();
  TextEditingController titleController = TextEditingController();
  String title;
  bool isEditing;

  @override
  void initState() {
    super.initState();
    titleController.text = appController.markers[widget.index].title;
    title = titleController.text;
    isEditing = false;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.label),
        title: isEditing
            ? TextFormField(
                controller: titleController,
                onChanged: (valor) => setState(() {
                  appController.markers[widget.index].title = valor;
                  title = valor;
                }),
              )
            : Text(
                appController.markers[widget.index].title,
              ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => setState(() {
                      isEditing = !isEditing;
                      if (isEditing == false) {
                        final newMarker = appController.markers[widget.index];
                        newMarker.title = title;
                        appController.updateMarker(
                            index: widget.index, newMarker: newMarker);
                      }
                    })),
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  appController.removeMarker(index: widget.index);
                }),
          ],
        ),
      ),
    );
  }
}
