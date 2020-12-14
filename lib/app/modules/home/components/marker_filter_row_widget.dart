import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/data/marker_dao.dart';
import 'package:my_anoteds/app/model/marker.dart';
import 'package:my_anoteds/app/model/user.dart';

Widget MarkerFilterRowWidget() {
  final loggedUser = Modular.get<User>();
  final markerDao = Modular.get<MarkerDao>();

  return FutureBuilder(
      future: markerDao.getMarkers(loggedUser.id),
      builder: (BuildContext context, AsyncSnapshot<List<Marker>> snapshot) {
        return snapshot.hasData
            ? Consumer<User>(builder: (context, value) {
          loggedUser.markers = snapshot.data;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: loggedUser.markers.length,
            itemBuilder: (BuildContext context, int index) =>
                MarkerFilterElementWidget(index),
          );
        })
            : CircularProgressIndicator();
      });
}

/// [Widget] elemento da lista de [Marker] filtro.
class MarkerFilterElementWidget extends StatefulWidget {
  final int index;

  MarkerFilterElementWidget(this.index);

  @override
  _State createState() => _State();
}

class _State extends State<MarkerFilterElementWidget> {
  final loggedUser = Modular.get<User>();
  Color cor = Colors.transparent;
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          FlatButton(
            textColor: Colors.black,
            color: cor,
            onPressed: () {
              setState(() {
                if (cor == Colors.transparent) {
                  cor = Colors.greenAccent;
                  isActive = true;
                } else {
                  cor = Colors.transparent;
                  isActive = false;
                }
              });
            },
            child: Text(loggedUser.markers[widget.index].title),
          ),
          SizedBox(width: 5),
        ],
      ),
    );
  }
}