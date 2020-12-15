import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/data/marker_dao.dart';
import 'package:my_anoteds/app/data/marking_dao.dart';
import 'package:my_anoteds/app/model/marker.dart';
import 'package:my_anoteds/app/model/user.dart';

class MarkerController {
  final markerDao = Modular.get<MarkerDao>();
  final markingDao = Modular.get<MarkingDao>();
  final loggedUser = Modular.get<User>();

  /// Adiciona um [Marker], armazenando em sua tabela no Banco de Dados.
  addMarker({Marker marker}) {
    loggedUser.addMarker(marker: marker);
    markerDao.insertMarker(marker);
  }

  /// Atualiza um [Marker], atualizando o mesmo em sua tabela no Banco de Dados.
  updateMarker({int index, Marker newMarker}) {
    loggedUser.updateMarker(index: index, newMarker: newMarker);
    markerDao.updateMarker(newMarker);
  }

  /// Deleta um [Marker], deletando o mesmo em sua tabela no Banco de Dados.
  removeMarker({int index}) {
    final id = loggedUser.markers[index].id;
    loggedUser.removeMarker(index: index);
    markerDao.deleteMarker(id);
    markingDao.deleteMarkerMarkings(markerId: id);
  }

  /// Salva um marker  dado um [title] e um [userId].
  saveMarker({String title, int userId}) {
    final newMarker = Marker(title: title, userId: userId);

    addMarker(marker: newMarker);
  }

  initializeUserMarkers({User loggedUser}) async {
    await markerDao
        .getMarkers(loggedUser.id)
        .then((value) => loggedUser.setMarkers(markers: value));
  }
}
