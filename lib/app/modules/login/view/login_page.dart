import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/Utils/utils.dart';
import 'package:my_anoteds/app/data/users_dao.dart';
import 'package:my_anoteds/app/model/user.dart';
import 'package:my_anoteds/app/modules/home/view/home_page.dart';
import 'package:my_anoteds/app/modules/login/view/signup_page.dart';

class LoginPage extends StatefulWidget {
  static const routeName = "/";

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passControleer = TextEditingController();
  String userName = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('My Annoteds')),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    'Fazer Login',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  ),
                )),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                onChanged: (valor) =>
                    setState(() => userName = valor.trim().toLowerCase()),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Usuário',
                ),
              ),
            ),
            SizedBox(height: 5),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                controller: passControleer,
                onChanged: (valor) => setState(() => password = valor),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Senha',
                ),
              ),
            ),
            SizedBox(height: 5),
            Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: RaisedButton(
                textColor: Colors.black,
                child: Text('Entrar'),
                onPressed: () {
                  signin(userName: userName, password: password, context: context);
                },
              ),
            ),
            SizedBox(height: 7),
            FlatButton(
              onPressed: () {
                Modular.link.pushNamed(SignInPage.routeName);
              },
              child: Text('Não é cadastrado? Cadastre-se aqui!',
                  style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}

signin({String userName, String password, BuildContext context}) async {
  final userDao = Modular.get<UserDao>();
  User loggedUser;
  await userDao.getUser(username: userName, password: password).then((value) {
    loggedUser = value;
    if (loggedUser != null){
      Modular.to.pushReplacementNamed(HomePage.routeName);
    } else{
      Utils.showAlertDialog(context, 'Atenção!', "Usuário não encontrado ou senha incorreta", "Ok");
    }
  });
}

/// Este metodo remove o focus de um widget.
removeFocus({BuildContext context}) {
  final FocusScopeNode currentFocus = FocusScope.of(context);

  // Remove o focus do widget atual
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}
