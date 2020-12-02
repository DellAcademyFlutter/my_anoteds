import 'package:my_anoteds/app/modules/home/model/postit.dart';
import 'package:flutter/cupertino.dart';

class User extends ChangeNotifier {
  // Construtor da classe
  User({this.postits});

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
    postits[index].is_pinned = newPostit.is_pinned;

    notifyListeners();
  }

  removePostit({int index}){
    postits.removeAt(index);

    notifyListeners();
  }
}
