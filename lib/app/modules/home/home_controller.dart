import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/app_controller.dart';
import 'package:my_anoteds/app/data/marking_dao.dart';
import 'package:my_anoteds/app/data/postit_dao.dart';
import 'package:my_anoteds/app/model/marker.dart';
import 'package:my_anoteds/app/model/marking.dart';
import 'package:my_anoteds/app/model/postit.dart';
import 'package:my_anoteds/app/model/user.dart';
import 'package:my_anoteds/app/modules/login/view/login_page.dart';

class HomeController {
  final appController = Modular.get<AppController>();

  /// Remove um [Marking] de um [Postit].
  removeMarking({int userId, int postitId, int markerId}) {
    final markerToRemove =
        Marking(userId: userId, postitId: postitId, markerId: markerId);

    appController.removeMarking(marking: markerToRemove);
  }

  /// Realiza logout de usuario.
  Logout() {
    final nullUser = User(
      id: null,
      name: null,
      password: null,
      email: null,
      birth: null,
    );
    appController.loggedUser.setValues(otherUser: nullUser);
    Modular.to.pushReplacementNamed(LoginPage.routeName);
  }

  /// Inicializa os [Marker]s de um [Postit]
  Future<List<int>> initializePostitMarkers(
      {User loggedUser, Postit postit}) async {
    final markingDao = Modular.get<MarkingDao>();
    List<int> postitMarkers;

    await markingDao
        .getPostitMarkersIds(userId: loggedUser.id, postitId: postit.id)
        .then((value) => postitMarkers = value);
    return postitMarkers;
  }

  /// Inicializa os [Postit]s do [User] logado no sistema.
  initializeLoggedUserPostits({User loggedUser}) async {
    final appController = Modular.get<AppController>();
    final postitDao = Modular.get<PostitDao>();

    await postitDao
        .getPostits(userId: loggedUser.id)
        .then((value) => appController.setPostits(postits: value));
  }

  /// Inicializa os [Postit]s do [User] logado no sistema.
  filterUserPostitsWithMarkers({User loggedUser, List<int> markersId}) async {
    final appController = Modular.get<AppController>();
    final postitDao = Modular.get<PostitDao>();

    await postitDao
        .getMarkedPostits(userId: loggedUser.id, markersId: markersId)
        .then((value) => appController.setPostits(postits: value));
  }
}
