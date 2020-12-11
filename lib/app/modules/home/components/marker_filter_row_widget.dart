import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/controller/marker_controller.dart';
import 'package:my_anoteds/app/data/marker.dao.dart';
import 'package:my_anoteds/app/model/marker.dart';
import 'package:my_anoteds/app/model/user.dart';

class MarkerFilterRowWidget extends StatelessWidget {
  MarkerFilterRowWidget();

  final loggedUser = Modular.get<User>();
  final markerDao = Modular.get<MarkerDao>();
  final markerController = Modular.get<MarkerController>();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Expanded(
        child: SizedBox(
          height: 200,
          child: FutureBuilder(
              future: markerDao.getMarkers(loggedUser.id),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Marker>> snapshot) {
                return snapshot.hasData
                    ? Consumer<User>(builder: (context, value) {
                        loggedUser.markers = snapshot.data;
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: loggedUser.markers
                                .map<Expanded>((Marker listItemValue) {
                              return Expanded(
                                child: ListTile(
                                  leading: Icon(Icons.label_outline_rounded),
                                  title: Text(listItemValue.title),
                                ),
                              ); //Card(child: Text(listItemValue.title),);
                            }).toList(),
                          ),
                        );
                      })
                    : CircularProgressIndicator();
              }),
        ),
      ),
    );
  }
}

class PopupMenuWidget extends StatelessWidget {
  PopupMenuWidget({
    Key key,
  }) : super(key: key);

  final User loggedUser = Modular.get();
  final markerDao = Modular.get<MarkerDao>();
  final markerController = Modular.get<MarkerController>();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: FutureBuilder(
          future: markerDao.getMarkers(loggedUser.id),
          builder:
              (BuildContext context, AsyncSnapshot<List<Marker>> snapshot) {
            return snapshot.hasData
                ? Consumer<User>(builder: (context, value) {
                    loggedUser.markers = snapshot.data;
                    return PopupMenuButton<int>(onSelected: (int result) {
                      Marker oldMarker = loggedUser.getMarkerById(id: result);
                      Marker newMarker = Marker(
                        id: oldMarker.id,
                        title: oldMarker.title,
                        userId: oldMarker.userId,
                        isSelected: (oldMarker.isSelected) ? false : true,
                      );
                      markerController.updateMarker(
                          index: loggedUser.markers.indexOf(oldMarker), newMarker: newMarker);
                    }, itemBuilder: (context) {
                      return loggedUser.markers
                          .map<CheckedPopupMenuItem<int>>((Marker listItemValue) {
                        return CheckedPopupMenuItem(
                          checked: listItemValue.isSelected,
                            value: listItemValue.id,
                            child: Text(listItemValue.title),
                            ); //Card(child: Text(listItemValue.title),);
                      }).toList();
                    });
                  })
                : CircularProgressIndicator();
          }),
    );
  }
}
