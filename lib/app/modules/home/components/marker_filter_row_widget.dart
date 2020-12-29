import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/data/marker_dao.dart';
import 'package:my_anoteds/app/model/marker.dart';
import 'package:my_anoteds/app/modules/home/home_controller.dart';

import '../../../app_controller.dart';

Widget MarkerFilterRowWidget() {
  final appController = Modular.get<AppController>();
  final markerDao = Modular.get<MarkerDao>();
  final selectedMarkers = <int>[];

  return FutureBuilder(
      future: markerDao.getMarkers(appController.loggedUser.id),
      builder: (BuildContext context, AsyncSnapshot<List<Marker>> snapshot) {
        return snapshot.hasData
            ? Consumer<AppController>(builder: (context, value) {
                appController.markers = snapshot.data;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: appController.markers.length,
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
  final appController = Modular.get<AppController>();
  final homeController = Modular.get<HomeController>();
  Color color = Colors.white;
  Color activeColor = Colors.greenAccent;
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          FlatButton(
            color: color,
            onPressed: () {
              setState(() {
                // Modificar os botoes
                if (!isActive) {
                  color = activeColor;
                  isActive = true;
                  widget.selectedMarkers
                      .add(appController.markers[widget.index].id);
                } else {
                  color = Colors.white;
                  isActive = false;
                  widget.selectedMarkers
                      .remove(appController.markers[widget.index].id);
                }

                // Modificar a lista  ser exibida
                homeController.filterUserPostitsWithMarkers(
                    loggedUser: appController.loggedUser,
                    markersId: widget.selectedMarkers);
              });
            },
            child: Text(appController.markers[widget.index].title,
            style: TextStyle(color: Colors.black),),
          ),
          SizedBox(width: 5),
        ],
      ),
    );
  }
}
