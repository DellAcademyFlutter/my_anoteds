import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/controller/marking_controller.dart';
import 'package:my_anoteds/app/controller/postit_controller.dart';
import 'package:my_anoteds/app/data/marking_dao.dart';
import 'package:my_anoteds/app/model/marking.dart';
import 'package:my_anoteds/app/model/postit.dart';
import 'package:my_anoteds/app/model/user.dart';
import 'package:my_anoteds/app/modules/login/view/login_page.dart';

class HomeController {
  savePostit(
      {String title,
      String description,
      String color,
      Postit postit,
      String base64Image,
      List<int> postitMarkers}) {
    final loggedUser = Modular.get<User>();
    final postitController = Modular.get<PostitController>();

    final newPostit = Postit(
        id: postit?.id,
        title: title ?? "",
        description: description ?? "",
        color: color,
        userId: loggedUser.id,
        isPinned: postit?.isPinned ?? false,
        image: base64Image);

    // Editar o postit
    if (postit != null) {
      postitController
          .updatePostit(
              index: loggedUser.postits.indexOf(postit), newPostit: newPostit)
          .then((value) => associateMarkersToPostit(
              userId: loggedUser.id,
              postitId: postit.id,
              postitMarkers: postitMarkers));
    }

    // Adicionar o postit
    else {
      postitController.addPostit(postit: newPostit).then((value) =>
          associateMarkersToPostit(
              userId: loggedUser.id,
              postitId: value,
              postitMarkers: postitMarkers));
    }
  }

  /// Associa um [Postit] de um [User] com varios [Marker]s dados.
  associateMarkersToPostit(
      {int userId, int postitId, List<int> postitMarkers}) {
    final markingController = Modular.get<MarkingController>();
    final markingDao = Modular.get<MarkingDao>();

    // Remove todos os markers antigos deste postit
    markingDao.deletePostitMarkers(userId: userId, postitId: postitId);

    // Adicionar todos os markers do postit
    if (postitMarkers.isNotEmpty) {
      for (var i = 0; i < postitMarkers.length; i++) {
        Marking newMarking = Marking(
          userId: userId,
          postitId: postitId,
          markerId: postitMarkers[i],
        );
        markingController.addMarking(marking: newMarking);
      }
    }
  }

  removeMarking({int userId, int postitId, int markerId}) {
    final markingController = Modular.get<MarkingController>();
    Marking markerToRemove =
        Marking(userId: userId, postitId: postitId, markerId: markerId);

    markingController.removeMarking(marking: markerToRemove);
  }

  /// Realiza logout de usuario.
  Logout() {
    final loggedUser = Modular.get<User>();
    final nullUser = User(
      id: null,
      name: null,
      password: null,
      email: null,
      birth: null,
    );
    loggedUser.setValues(otherUser: nullUser);
    Modular.to.pushReplacementNamed(LoginPage.routeName);
  }

  Future<List<int>> initializePostitMarkers({User loggedUser, Postit postit}) async {
    final markingDao = Modular.get<MarkingDao>();
    List<int> postitMarkers;

    await markingDao.getPostitMarkersIds(
        userId: loggedUser.id, postitId: postit.id).then((value) => postitMarkers = value);
    return postitMarkers;
  }
}
