import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/modules/home/home_page.dart';

import 'package:my_anoteds/app/repositories/shared/Utils/utils.dart';
import 'package:my_anoteds/app/data/users_dao.dart';
import 'package:my_anoteds/app/model/user.dart';

class LoginController {
  signIn({String name, String password, BuildContext context}) async {
    final userDao = Modular.get<UserDao>();
    User loggedUser;

    await userDao.getUser(username: name, password: password).then((value) {
      loggedUser = value;
      if (loggedUser != null) {
        Modular.get<User>().setValues(otherUser: value);
        Modular.to.pushReplacementNamed(HomePage.routeName);
      } else {
        Utils.showAlertDialog(context, 'Atenção!',
            "Usuário não encontrado ou senha incorreta", "Ok");
      }
    });
  }


}
