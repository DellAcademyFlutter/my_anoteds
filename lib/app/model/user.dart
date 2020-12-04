import 'package:flutter/cupertino.dart';
import 'package:my_anoteds/app/model/postit.dart';

class User extends ChangeNotifier {
  // Construtor da classe
  User({this.id, this.name, this.password, this.email, this.birth, this.postits});

  int id;
  String name;
  String password;
  String email;
  String birth;

  /// Serialização - Atribui os valores dos parametros de [User] dado um [Map] Jason.
  User.fromMap({Map<String, dynamic> map}) {
    id = map['id'];
    name = map['name'];
    email = map['email'];
    password = map['password'];
    birth = map['birth'];
  }

  /// Este metodo codifica este [Postit] em um [Map] Json.
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['birth'] = this.birth;
    return data;
  }

  setValues({@required User otherUser}){
    id = otherUser.id;
    name = otherUser.name;
    password = otherUser.password;
    email = otherUser.email;
    birth = otherUser.birth;
  }
  // Atributos da classe
  List<Postit> postits;

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
}
