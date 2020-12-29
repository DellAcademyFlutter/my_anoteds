import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/data/marker_dao.dart';
import 'package:my_anoteds/app/model/marker.dart';
import 'package:my_anoteds/app/model/user.dart';

import '../../app_controller.dart';

class CrudMarkerController {
  final appController = Modular.get<AppController>();
  final markerDao = Modular.get<MarkerDao>();

  /// Salva um marker  dado um [title] e um [userId].
  saveMarker({String title, int userId}) {
    final newMarker = Marker(title: title, userId: userId);

    appController.addMarker(marker: newMarker);
  }

  /// Inicializa os [Marker]s do [User].
  initializeUserMarkers({User loggedUser}) async {
    await markerDao
        .getMarkers(loggedUser.id)
        .then((value) => appController.setMarkers(markers: value));
  }
}
