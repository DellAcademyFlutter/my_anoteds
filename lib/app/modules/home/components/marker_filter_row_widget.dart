import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/data/marker_dao.dart';
import 'package:my_anoteds/app/model/marker.dart';
import 'package:my_anoteds/app/model/user.dart';
import 'package:my_anoteds/app/modules/home/home_controller.dart';

Widget MarkerFilterRowWidget() {
  final loggedUser = Modular.get<User>();
  final markerDao = Modular.get<MarkerDao>();
  final selectedMarkers = <int>[];

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
                      MarkerFilterElementWidget(
                    index: index,
                    selectedMarkers: selectedMarkers,
                  ),
                );
              })
            : CircularProgressIndicator();
      });
}

/// [Widget] elemento da lista de [Marker] filtro.
class MarkerFilterElementWidget extends StatefulWidget {
  final int index;
  final List<int> selectedMarkers;

  MarkerFilterElementWidget({this.index, this.selectedMarkers});

  @override
  _State createState() => _State();
}

class _State extends State<MarkerFilterElementWidget> {
  final loggedUser = Modular.get<User>();
  final homeController = Modular.get<HomeController>();
  Color color = Colors.transparent;
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          FlatButton(
            textColor: Colors.black,
            color: color,
            onPressed: () {
              setState(() {
                // Modificar os botoes
                if (!isActive){
                  color = Theme.of(context).buttonColor;
                  isActive = true;
                  widget.selectedMarkers.add(loggedUser.markers[widget.index].id);
                } else {
                  color = Colors.transparent;
                  isActive = false;
                  widget.selectedMarkers.remove(loggedUser.markers[widget.index].id);
                }

                // Modificar a lista  ser exibida
                homeController.filterUserPostitsWithMarkers(loggedUser: loggedUser, markersId: widget.selectedMarkers);
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
