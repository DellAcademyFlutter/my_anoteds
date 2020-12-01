import 'package:my_anoteds/app/modules/home/model/postit.dart';
import 'package:flutter/cupertino.dart';

class User extends ChangeNotifier{
  // Construtor da classe
  User({this.postits});

  // Atributos da classe
  List<Postit> postits;

  // Adiciona um Postit
  addPostit ({Postit postit}){
    postits.add(postit);

    notifyListeners();
  }
}