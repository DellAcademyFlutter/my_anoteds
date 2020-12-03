import 'package:my_anoteds/app/modules/home/model/postit.dart';
import 'package:flutter/cupertino.dart';

class User extends ChangeNotifier {
  // Construtor da classe
  User({this.id, this.name, this.pass, this.email, this.birth, this.postits});

  int id;
  String name;
  String pass;
  String email;
  String birth;

  /// Atribui os valores dos parametros de [User] dado um [Map] Jason.
  User.fromMap({Map<String, dynamic> map}) {
    id = map['id'];
    name = map['name'];
    email = map['email'];
    pass = map['pass'];
    birth = map['birth'];
  }

  /// Este metodo codifica este [Postit] em um [Map] Json.
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['pass'] = this.pass;
    data['birth'] = this.birth;
    return data;
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
