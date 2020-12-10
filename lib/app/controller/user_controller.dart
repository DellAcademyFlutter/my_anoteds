import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/data/users_dao.dart';
import 'package:my_anoteds/app/model/user.dart';

class UserController {
  final userDao = Modular.get<UserDao>();

  /// Adiciona um [user], armazenando em sua tabela no Banco de Dados.
  addUser({User user}) {
    userDao.insertUser(user);
  }

  static saveUser({String name, String birth, String pass, String email}) {
    final controller = Modular.get<UserController>();

    final newUser =
        User(id: null, name: name, password: pass, birth: birth, email: email);

    controller.addUser(user: newUser);
  }
}
