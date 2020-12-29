import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/data/marker_dao.dart';
import 'package:my_anoteds/app/data/marking_dao.dart';
import 'package:my_anoteds/app/data/postit_dao.dart';
import 'package:my_anoteds/app/data/users_dao.dart';
import 'package:my_anoteds/app/model/marker.dart';
import 'package:my_anoteds/app/model/marking.dart';
import 'package:my_anoteds/app/model/postit.dart';
import 'package:my_anoteds/app/model/user.dart';

class AppController extends ChangeNotifier {
  // Injecoes de dependencia
  final userDao = Modular.get<UserDao>();
  final postitDao = Modular.get<PostitDao>();
  final markerDao = Modular.get<MarkerDao>();
  final markingDao = Modular.get<MarkingDao>();

  // Atributos da classe
  final loggedUser = Modular.get<User>();
  List<Postit> postits;
  List<Marker> markers;

  /// Adiciona um [user], armazenando em sua tabela no Banco de Dados.
  addUser({User user}) {
    userDao.insertUser(user);
  }

  /// Salva um [User] em sua tabela no Banco de Dados.
  saveUser({String name, String birth, String password, String email}) {
    final newUser = User(
        id: null, name: name, password: password, birth: birth, email: email);

    addUser(user: newUser);
  }

  /// Salva um [User] em sua tabela no Banco de Dados.
  saveLoggedUser({String name}) {
    userDao.insertLoggedUser(name);
  }

  /// Salva um [User] em sua tabela no Banco de Dados.
  deleteLoggedUser({String name}) {
    userDao.deleteLoggedUser(name);
  }

  Future<User> getLoggedUser() async {
    final userDao = Modular.get<UserDao>();
    User loggedUser;

    await userDao.getLoggedUser().then((value) {
      loggedUser = value;
      if (loggedUser != null) {
        return loggedUser;
      } else {
        return null;
      }
    });
  }

  /// Atribui a lista de [Postit] do usuario com uma dada lista de [Postit].
  setPostits({List<Postit> postits}) {
    this.postits = postits;

    notifyListeners();
  }

  /// Adiciona um [Postit] na lista de [Postit]s e no BD.
  Future<int> addPostit({Postit postit}) async {
    int generatedId;
    await postitDao.insertPostit(postit).then((value) => generatedId = value);
    postit.id = generatedId; // Insere o Id gerado pelo auto-incremente.
    postits.add(postit);

    notifyListeners();
    return generatedId;
  }

  /// Atualiza um [Postit] na lista de [Postit]s e no BD.
  Future<int> updatePostit({int index, Postit newPostit}) async {
    await postitDao.updatePostit(newPostit);
    postits[index].setValues(otherPostit: newPostit);

    notifyListeners();
    return newPostit.id;
  }

  /// Deleta um [Postit] da lista de [Postit]s e no BD.
  removePostit({int index}) async {
    final postitId = postits[index].id;
    await postitDao.deletePostit(postitId);
    await markingDao.deletePostitMarkings(postitId: postitId);
    postits.removeAt(index);

    notifyListeners();
  }

  /// Atribui a lista de [Marker] do usuario com uma dada lista de [Marker].
  setMarkers({List<Marker> markers}) {
    this.markers = markers;

    notifyListeners();
  }

  /// Adiciona um [Marker] a lista de [Marker]s e no BD.
  addMarker({Marker marker}) async {
    int generatedId;
    await markerDao.insertMarker(marker).then((value) => generatedId = value);
    marker.id = generatedId;
    markers.add(marker);

    notifyListeners();
  }

  /// Atualiza um [Marker] na lista de [Marker]s e no BD.
  updateMarker({int index, Marker newMarker}) async {
    await markerDao.updateMarker(newMarker);

    markers[index].id = newMarker.id;
    markers[index].title = newMarker.title;
    notifyListeners();
  }

  /// Deleta um [Marker] da lista de [Marker]s e no BD.
  removeMarker({int index}) async {
    final id = markers[index].id;
    await markerDao.deleteMarker(id);
    await markingDao.deleteMarkerMarkings(markerId: id);
    markers.removeAt(index);

    notifyListeners();
  }

  /// Busca e retorna um titulo de um [Marker] por seu id.
  String getMarkerTitleById({int markerId}) {
    for (var i = 0; i < markers.length; i++) {
      if (markers[i].id == markerId) {
        return markers[i].title;
      }
    }
    return "NothingFound";
  }

  /// Busca e retorna um [Marker] por seu id.
  Marker getMarkerById({int id}) {
    for (var i = 0; i < markers.length; i++) {
      if (markers[i].id == id) {
        return markers[i];
      }
    }
    return null;
  }

  /// Adiciona um [user], armazenando em sua tabela no Banco de Dados.
  addMarking({Marking marking}) async {
    await markingDao.insertMarking(marking);
  }

  /// Adiciona um [user], armazenando em sua tabela no Banco de Dados.
  removeMarking({Marking marking}) async {
    await markingDao.deleteMarking(marking);
  }
}
