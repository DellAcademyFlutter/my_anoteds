import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/data/marker_dao.dart';
import 'package:my_anoteds/app/data/marking_dao.dart';
import 'package:my_anoteds/app/model/marking.dart';
import 'package:my_anoteds/app/model/postit.dart';

import '../../app_controller.dart';

class CrudPostitController {
  final appController = Modular.get<AppController>();
  final markerDao = Modular.get<MarkerDao>();
  final markingDao = Modular.get<MarkingDao>();

  /// Salva um [Postit], seja adicao ou edicao.
  savePostit(
      {String title,
      String description,
      String color,
      Postit postit,
      String base64Image,
      List<int> postitMarkers}) {
    final newPostit = Postit(
        id: postit?.id,
        title: title ?? "",
        description: description ?? "",
        color: color,
        userId: appController.loggedUser.id,
        isPinned: postit?.isPinned ?? false,
        image: base64Image);

    // Editar o postit
    if (postit != null) {
      appController
          .updatePostit(
              index: appController.postits.indexOf(postit),
              newPostit: newPostit)
          .then((value) => associateMarkersToPostit(
              userId: appController.loggedUser.id,
              postitId: postit.id,
              postitMarkers: postitMarkers));
    }

    // Adicionar o postit
    else {
      appController.addPostit(postit: newPostit).then((value) =>
          associateMarkersToPostit(
              userId: appController.loggedUser.id,
              postitId: value,
              postitMarkers: postitMarkers));
    }
  }

  /// Associa um [Postit] de um [User] com varios [Marker]s dados.
  associateMarkersToPostit(
      {int userId, int postitId, List<int> postitMarkers}) {
    final markingDao = Modular.get<MarkingDao>();

    // Remove todos os markers antigos deste postit
    markingDao.deletePostitMarkers(userId: userId, postitId: postitId);

    // Adicionar todos os markers do postit
    if (postitMarkers.isNotEmpty) {
      for (var i = 0; i < postitMarkers.length; i++) {
        final newMarking = Marking(
          userId: userId,
          postitId: postitId,
          markerId: postitMarkers[i],
        );
        appController.addMarking(marking: newMarking);
      }
    }
  }
}
