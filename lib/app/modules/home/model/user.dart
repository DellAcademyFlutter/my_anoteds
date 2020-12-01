import 'package:flutter/cupertino.dart';
import 'package:my_anoteds/app/modules/home/model/postit.dart';

class User extends ChangeNotifier{
  User({this.postits});

  List<Postit> postits;

  addPostit({Postit postit}){
    postits.add(postit);

    notifyListeners();
  }
}