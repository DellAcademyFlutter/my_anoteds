import 'package:flutter_modular/flutter_modular.dart';
import '../data/postit_dao.dart';
import '../model/postit.dart';
import '../model/user.dart';

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
}
