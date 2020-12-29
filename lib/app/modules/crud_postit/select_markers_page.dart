import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/app_controller.dart';
import 'package:my_anoteds/app/data/marker_dao.dart';
import 'package:my_anoteds/app/model/marker.dart';
import 'package:my_anoteds/app/model/user.dart';
import 'package:my_anoteds/app/modules/crud_postit/presenter/crud_postit_presenter.dart';


class SelectMarkersPageArguments {
  SelectMarkersPageArguments({this.presenter});

  final CrudPostitPresenter presenter;
}

class SelectMarkersPage extends StatefulWidget {
  static const routeName = "/markerSelectPage";

  SelectMarkersPage({this.presenter});

  final CrudPostitPresenter presenter;

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SelectMarkersPage> {
  final appController = Modular.get<AppController>();
  final markerDao = Modular.get<MarkerDao>();

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
            future: markerDao.getMarkers(appController.loggedUser.id),
            builder:
                (BuildContext context, AsyncSnapshot<List<Marker>> snapshot) {
              return snapshot.hasData
                  ? Consumer<AppController>(builder: (context, value) {
                      appController.markers = snapshot.data;
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: appController.markers.length,
                        itemBuilder: (BuildContext context, int index) =>
                            SelectMarkerWidget(
                          index: index,
                          callbackAddMarker: widget.presenter.addMarker,
                          callbackRemoveMarker: widget.presenter.removeMarker,
                          priorAddedMarkers: widget.presenter.postitMarkers,
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
  final appController = Modular.get<AppController>();
  bool isSelected = false;

  atualizeStatus() {
    setState(() {
      isSelected = !isSelected;
      isSelected
          ? widget.callbackAddMarker(
              markerId: appController.markers[widget.index].id)
          : widget.callbackRemoveMarker(
              markerId: appController.markers[widget.index].id);
    });
  }

  @override
  void initState() {
    super.initState();

    isSelected = widget.priorAddedMarkers
        .contains(appController.markers[widget.index].id);
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
            appController.markers[widget.index].title,
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
