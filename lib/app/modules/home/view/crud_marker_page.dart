import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/controller/marker_controller.dart';
import 'package:my_anoteds/app/data/marker_dao.dart';
import 'package:my_anoteds/app/model/marker.dart';
import 'package:my_anoteds/app/model/user.dart';

class CrudMarkerPage extends StatefulWidget {
  static const routeName = "/CrudMarkerPage";
  CrudMarkerPage();

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<CrudMarkerPage> {
  TextEditingController markertitle = TextEditingController();
  final User loggedUser = Modular.get();
  final markerDao = Modular.get<MarkerDao>();
  final markerController = Modular.get<MarkerController>();
  String title;

  callbackRefresh() {
    setState(() {});
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
                  markerController.saveMarker(
                      title: title, userId: loggedUser.id);
                },
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: SizedBox(
                height: 200,
                child: FutureBuilder(
                    future: markerDao.getMarkers(loggedUser.id),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Marker>> snapshot) {
                      return snapshot.hasData
                          ? Consumer<User>(builder: (context, value) {
                              loggedUser.markers = snapshot.data;
                              return ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: loggedUser.markers.length,
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        CrudMarkerWidget(
                                  index: index,
                                  markerTitle: title,
                                  callbackRefresh: callbackRefresh,
                                ),
                              );
                            })
                          : CircularProgressIndicator();
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
  CrudMarkerWidget({this.index, this.markerTitle, this.callbackRefresh});
  final int index;
  final String markerTitle;
  final Function callbackRefresh;

  @override
  _CrudMarkerWidgetState createState() => _CrudMarkerWidgetState();
}

class _CrudMarkerWidgetState extends State<CrudMarkerWidget> {
  final loggedUser = Modular.get<User>();
  final markerController = Modular.get<MarkerController>();
  TextEditingController titleController = TextEditingController();
  bool isEditing;
  String title;

  @override
  void initState() {
    super.initState();
    titleController.text = loggedUser.markers[widget.index].title;
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
                  title = valor;
                }),
              )
            : Text(
                title,
              ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => setState(() {
                      isEditing = !isEditing;
                      if (isEditing == false) {
                        final newMarker = loggedUser.markers[widget.index];
                        newMarker.title = title;
                        markerController.updateMarker(
                            index: widget.index, newMarker: newMarker);
                      }
                    })),
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  markerController.removeMarker(
                      id: loggedUser.markers[widget.index].id);
                  widget.callbackRefresh();
                }),
          ],
        ),
      ),
    );
  }
}
