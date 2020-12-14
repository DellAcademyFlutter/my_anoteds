import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/modules/home/view/select_markers_page.dart';

class CrudPostitSettingsMenuWidget extends StatefulWidget {
  CrudPostitSettingsMenuWidget(
      {this.callbackAddMarker,
      this.callbackRemoveMarker,
      this.priorAddedMarkers});
  final Function callbackAddMarker;
  final Function callbackRemoveMarker;
  final List<int> priorAddedMarkers;

  @override
  _State createState() => _State();
}

/// This is the private State class that goes with MyStatefulWidget.
class _State extends State<CrudPostitSettingsMenuWidget> {
  final options = ['Marcadores'];
  String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = options[0];
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(onSelected: (String value) {
      if (value == 'Marcadores') {
        Modular.link.pushNamed(SelectMarkersPage.routeName,
            arguments: SelectMarkersPageArguments(
                callbackAddMarker: widget.callbackAddMarker,
                callbackRemoveMarker: widget.callbackRemoveMarker,
                priorAddedMarkers: widget.priorAddedMarkers));
      }
    }, itemBuilder: (context) {
      return options.map<PopupMenuItem<String>>((String option) {
        return PopupMenuItem<String>(
          value: option,
          child: ListTile(
            leading: Icon(Icons.label),
            title: Text(option),
          ),
        );
      }).toList();
    });
  }
}
