import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/data/postit_dao.dart';
import 'package:my_anoteds/app/model/postit.dart';
import 'package:my_anoteds/app/model/user.dart';

class PostitController {
  final user = Modular.get<User>();
  final postitDao = Modular.get<PostitDao>();

  /// Adiciona um [Postit], armazenando em sua tabela no Banco de Dados.
  addPostit({Postit postit}) {
    user.addPostit(postit: postit);
    postitDao.insertPostit(postit);
  }

  /// Atualiza um [Postit], atualizando o mesmo em sua tabela no Banco de Dados.
  updatePostit({int index, Postit newPostit}) {
    user.updatePostit(index: index, newPostit: newPostit);
    postitDao.updatePostit(newPostit);
  }

  /// Deleta um [Postit], deletando o mesmo em sua tabela no Banco de Dados.
  removePostit({int index}) {
    final int postitId = user.postits[index].id;
    user.removePostit(index: index);
    postitDao.deletePostit(postitId);
  }

  static savePostit(
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
