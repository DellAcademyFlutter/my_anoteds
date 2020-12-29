import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/modules/crud_postit/presenter/crud_postit_presenter.dart';

import '../select_markers_page.dart';

class CrudPostitSettingsMenuWidget extends StatefulWidget {
  CrudPostitSettingsMenuWidget({this.presenter});
  final CrudPostitPresenter presenter;

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
            arguments: SelectMarkersPageArguments(presenter: widget.presenter));
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
