import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/data/marking_dao.dart';
import '../data/postit_dao.dart';
import '../model/postit.dart';
import '../model/user.dart';

class PostitController {
  final user = Modular.get<User>();
  final postitDao = Modular.get<PostitDao>();
  final markingDao = Modular.get<MarkingDao>();

  /// Adiciona um [Postit], armazenando em sua tabela no Banco de Dados.
  Future<int> addPostit({Postit postit}) async {
    int generatedId;
    await postitDao.insertPostit(postit).then((value) => generatedId = value);
    postit.id = generatedId; // Insere o Id gerado pelo auto-incremente.
    user.addPostit(postit: postit);
    return generatedId;
  }

  /// Atualiza um [Postit], atualizando o mesmo em sua tabela no Banco de Dados.
  Future<int> updatePostit({int index, Postit newPostit}) async {
    user.updatePostit(index: index, newPostit: newPostit);
    await postitDao.updatePostit(newPostit);
    return newPostit.id;
  }

  /// Deleta um [Postit], deletando o mesmo em sua tabela no Banco de Dados.
  removePostit({int index}) {
    final postitId = user.postits[index].id;
    user.removePostit(index: index);
    postitDao.deletePostit(postitId);
    markingDao.deletePostitMarkings(postitId: postitId);
  }
}
