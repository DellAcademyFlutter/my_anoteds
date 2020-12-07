import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/controller/postit_controller.dart';
import 'package:my_anoteds/app/model/postit.dart';
import 'package:my_anoteds/app/model/user.dart';

class HomeController{
  savePostit(
      {String title, String description, String color, Postit postit}) {
    final loggedUser = Modular.get<User>();
    final controller = Modular.get<PostitController>();

    final Postit newPostit = Postit(
        id: postit?.id ?? null,
        title: title ?? "",
        description: description ?? "",
        color: color,
        userId: loggedUser.id,
        isPinned: postit?.isPinned ?? false);

    // Editar o postit
    if (postit != null) {
      controller.updatePostit(
          index: loggedUser.postits.indexOf(postit), newPostit: newPostit);
    }
    // Adicionar o postit
    else {
      controller.addPostit(postit: newPostit);
    }
  }
}