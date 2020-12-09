import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/data/marker.dao.dart';
import 'package:my_anoteds/app/model/marker.dart';

class MarkerController {
  final markerDao = Modular.get<MarkerDao>();

  /// Adiciona um [user], armazenando em sua tabela no Banco de Dados.
  addMarker({Marker marker}) {
    markerDao.insertMarker(marker);
  }

  saveMarker({String title, int userId}) {
    final newMarker = Marker(title: title, userId: userId);

    addMarker(marker: newMarker);
  }
}
