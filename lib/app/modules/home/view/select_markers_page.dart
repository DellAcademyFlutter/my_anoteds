import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/controller/marker_controller.dart';
import 'package:my_anoteds/app/data/marker_dao.dart';
import 'package:my_anoteds/app/model/marker.dart';
import 'package:my_anoteds/app/model/user.dart';

class SelectMarkersPageArguments {
  SelectMarkersPageArguments(
      {this.callbackAddMarker,
      this.callbackRemoveMarker,
      this.priorAddedMarkers});

  Function callbackAddMarker;
  Function callbackRemoveMarker;
  List<int> priorAddedMarkers;
}

class SelectMarkersPage extends StatefulWidget {
  static const routeName = "/markerSelectPage";

  SelectMarkersPage(
      {this.callbackAddMarker,
      this.callbackRemoveMarker,
      this.priorAddedMarkers});

  final Function callbackAddMarker;
  final Function callbackRemoveMarker;
  final List<int> priorAddedMarkers;

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SelectMarkersPage> {
  final User loggedUser = Modular.get();
  final markerDao = Modular.get<MarkerDao>();
  final markerController = Modular.get<MarkerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecionar marcador(es)'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: FutureBuilder(
            future: markerDao.getMarkers(loggedUser.id),
            builder:
                (BuildContext context, AsyncSnapshot<List<Marker>> snapshot) {
              return snapshot.hasData
                  ? Consumer<User>(builder: (context, value) {
                      loggedUser.markers = snapshot.data;
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: loggedUser.markers.length,
                        itemBuilder: (BuildContext context, int index) =>
                            SelectMarkerWidget(
                          index: index,
                          callbackAddMarker: widget.callbackAddMarker,
                          callbackRemoveMarker: widget.callbackRemoveMarker,
                          priorAddedMarkers: widget.priorAddedMarkers,
                        ),
                      );
                    })
                  : CircularProgressIndicator();
            }),
      ),
    );
  }
}

/// [Widget] elemento da lista de [Marker] filtro.
class SelectMarkerWidget extends StatefulWidget {
  SelectMarkerWidget({
    @required this.index,
    @required this.callbackAddMarker,
    @required this.callbackRemoveMarker,
    @required this.priorAddedMarkers,
  });

  final int index;
  final Function callbackAddMarker;
  final Function callbackRemoveMarker;
  final List<int> priorAddedMarkers;

  @override
  _SelectMarkerWidgetState createState() => _SelectMarkerWidgetState();
}

class _SelectMarkerWidgetState extends State<SelectMarkerWidget> {
  final loggedUser = Modular.get<User>();
  final markerController = Modular.get<MarkerController>();
  bool isSelected = false;

  atualizeStatus() {
    setState(() {
      isSelected = !isSelected;
      isSelected
          ? widget.callbackAddMarker(markerID: loggedUser.markers[widget.index].id)
          : widget.callbackRemoveMarker(markerID: loggedUser.markers[widget.index].id);
    });
  }

  @override
  void initState() {
    super.initState();

    isSelected =
        widget.priorAddedMarkers.contains(loggedUser.markers[widget.index].id);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<User>(builder: (context, value) {
      return GestureDetector(
        onTap: () {
          atualizeStatus();
        },
        child: Card(
            child: Row(children: [
          Text(
            loggedUser.markers[widget.index].title,
          ),
          Spacer(),
          Checkbox(
            value: isSelected,
            onChanged: (value) => atualizeStatus(),
          )
        ])),
      );
    });
  }
}
