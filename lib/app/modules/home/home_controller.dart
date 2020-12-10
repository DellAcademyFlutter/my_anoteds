import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/controller/postit_controller.dart';
import 'package:my_anoteds/app/model/postit.dart';
import 'package:my_anoteds/app/model/user.dart';
import 'package:my_anoteds/app/modules/login/view/login_page.dart';

class HomeController {
  savePostit(
      {String title,
      String description,
      String color,
      Postit postit,
      String base64Image}) {
    final loggedUser = Modular.get<User>();
    final controller = Modular.get<PostitController>();

    final newPostit = Postit(
        id: postit?.id,
        title: title ?? "",
        description: description ?? "",
        color: color,
        userId: loggedUser.id,
        isPinned: postit?.isPinned ?? false,
        image: base64Image);

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



  Logout() {
    final loggedUser = Modular.get<User>();
    final nullUser = User(
        id: null,
        name: null,
        password: null,
        email: null,
        birth: null,
        postits: null);
    loggedUser.setValues(otherUser: nullUser);
    Modular.to.pushReplacementNamed(LoginPage.routeName);
  }
}
