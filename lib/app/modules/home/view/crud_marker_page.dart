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
            FutureBuilder(
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
                            itemBuilder: (BuildContext context, int index) =>
                                Card(
                              child: ListTile(
                                leading: Icon(Icons.label),
                                title: Text(
                                  loggedUser.markers[index].title,
                                ),
                              ),
                            ),
                          );
                        })
                      : CircularProgressIndicator();
                }),
          ],
        ),
      ),
    );
  }
}
