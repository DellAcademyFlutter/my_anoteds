import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/data/marking_dao.dart';
import 'package:my_anoteds/app/model/marking.dart';
import 'package:my_anoteds/app/model/user.dart';

class MarkingController {
  final markingDao = Modular.get<MarkingDao>();
  final loggedUser = Modular.get<User>();

  /// Adiciona um [user], armazenando em sua tabela no Banco de Dados.
  addMarking({Marking marking}) {
    markingDao.insertMarking(marking);
  }

  removeMarking({Marking marking}) {
    markingDao.deleteMarking(marking);
  }
}
