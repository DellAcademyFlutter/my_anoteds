import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/data/marker_dao.dart';
import 'package:my_anoteds/app/model/marker.dart';
import 'package:my_anoteds/app/model/user.dart';

class MarkerController {
  final markerDao = Modular.get<MarkerDao>();
  final loggedUser = Modular.get<User>();

  /// Adiciona um [user], armazenando em sua tabela no Banco de Dados.
  addMarker({Marker marker}) {
    loggedUser.addMarker(marker: marker);
    markerDao.insertMarker(marker);
  }

  /// Atualiza um [Postit], atualizando o mesmo em sua tabela no Banco de Dados.
  updateMarker({int index, Marker newMarker}) {
    loggedUser.updateMarker(index: index, newMarker: newMarker);
    markerDao.updateMarker(newMarker);
  }

  /// Salva um marker  dado um [title] e um [userId].
  saveMarker({String title, int userId}) {
    final newMarker = Marker(title: title, userId: userId);

    addMarker(marker: newMarker);
  }
}
