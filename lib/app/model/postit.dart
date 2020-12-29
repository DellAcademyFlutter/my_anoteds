import 'package:flutter/cupertino.dart';

class Postit {
  // Construtor da classe
  Postit(
      {this.id,
      this.title,
      this.description,
      this.color,
      this.userId,
      this.isPinned,
      this.image});

  // Atributos
  int id;
  String title;
  String description;
  String color;
  int userId;
  bool isPinned;
  String image;

  /// Atribui os valores dos parametros deste [Postit] dado um [Map] Jason.
  Postit.fromMap({Map<String, dynamic> map}) {
    id = map['id'];
    title = map['title'];
    description = map['description'];
    color = map['color'];
    userId = map['userId'];
    isPinned = map['isPinned'] == "1";
    image = map['image'];
  }

  /// Este metodo codifica este [Postit] em um [Map] Json.
  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['color'] = color;
    data['userId'] = userId;
    data['isPinned'] = (isPinned) ? 1 : 0;
    data['image'] = image;
    return data;
  }

  /// Atribui os valores dos atributos de um [Postit] a este [Postit].
  setValues({@required Postit otherPostit}) {
    id = otherPostit.id;
    title = otherPostit.title;
    description = otherPostit.description;
    color = otherPostit.color;
    userId = otherPostit.userId;
    isPinned = otherPostit.isPinned;
    image = otherPostit.image;
  }
}
