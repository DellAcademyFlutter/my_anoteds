import 'package:my_anoteds/app/model/postit.dart';
import 'package:flutter/cupertino.dart';

import 'marker.dart';

class User extends ChangeNotifier {
  // Construtor da classe
  User({this.id, this.name, this.password, this.email, this.birth, this.postits});

  int id;
  String name;
  String password;
  String email;
  String birth;

  /// Atribui os valores dos parametros de [User] dado um [Map] Jason.
  User.fromMap({Map<String, dynamic> map}) {
    id = map['id'];
    name = map['name'];
    email = map['email'];
    password = map['password'];
    birth = map['birth'];
  }

  /// Este metodo codifica este [Postit] em um [Map] Json.
  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['birth'] = birth;
    return data;
  }

  setValues({@required User otherUser}){
    id = otherUser.id;
    name = otherUser.name;
    email = otherUser.email;
    password = otherUser.password;
    birth = otherUser.birth;
  }


  // Atributos da classe
  List<Postit> postits;
  List<Marker> markers;

  // Adiciona um Postit
  addPostit({Postit postit}) {
    postits.add(postit);

    notifyListeners();
  }

  updatePostit({int index, Postit newPostit}) {
    postits[index].id = newPostit.id;
    postits[index].title = newPostit.title;
    postits[index].description = newPostit.description;
    postits[index].color = newPostit.color;
    postits[index].isPinned = newPostit.isPinned;

    notifyListeners();
  }

  removePostit({int index}){
    postits.removeAt(index);

    notifyListeners();
  }

  // Adiciona um marker
  addMarker({Marker marker}) {
    markers.add(marker);

    notifyListeners();
  }

  updateMarker({int index, Marker newMarker}) {
    markers[index].id = newMarker.id;
    markers[index].title = newMarker.title;
    markers[index].isSelected = newMarker.isSelected;
    notifyListeners();
  }

  removeMarker({int index}){
    markers.removeAt(index);

    notifyListeners();
  }

  Marker getMarkerById({int id}){
    for (var i=0; i<markers.length; i++){
      if (markers[i].id == id){
        return markers[i];
      }
    }
    return null;
  }
}
