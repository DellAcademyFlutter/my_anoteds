import 'package:my_anoteds/app/model/postit.dart';
import 'package:flutter/cupertino.dart';

class User extends ChangeNotifier {
  // Construtor da classe
  User({this.id, this.name, this.password, this.email, this.birth});

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

  /// Atribui os valores dos atributos de um [User] a este [User].
  setValues({@required User otherUser}) {
    id = otherUser.id;
    name = otherUser.name;
    email = otherUser.email;
    password = otherUser.password;
    birth = otherUser.birth;
  }
}
