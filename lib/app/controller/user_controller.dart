import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/data/users_dao.dart';
import 'package:my_anoteds/app/model/user.dart';

class UserController {
  final userDao = Modular.get<UserDao>();

  /// Adiciona um [user], armazenando em sua tabela no Banco de Dados.
  addUser({User user}) {
    userDao.insertUser(user);
  }

  /// Salva um [User] em sua tabela no Banco de Dados.
  saveUser({String name, String birth, String password, String email}) {
    final newUser =
    User(id: null,
        name: name,
        password: password,
        birth: birth,
        email: email);

    addUser(user: newUser);
  }

  /// Salva um [User] em sua tabela no Banco de Dados.
  saveLoggedUser({String name}) {
    userDao.insertLoggedUser(name);
  }

  /// Salva um [User] em sua tabela no Banco de Dados.
  deleteLoggedUser({String name}) {
    userDao.deleteLoggedUser(name);
  }

  Future<User> getLoggedUser() async {
    final userDao = Modular.get<UserDao>();
    User loggedUser;

    await userDao.getLoggedUser().then((value) {
      loggedUser = value;
      if (loggedUser != null) {
        return loggedUser;
      } else {
        return null;
      }
    });
  }
}