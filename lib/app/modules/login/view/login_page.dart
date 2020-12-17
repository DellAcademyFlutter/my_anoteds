import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/controller/user_controller.dart';
import 'package:my_anoteds/app/modules/login/view/signup_page.dart';

import '../login_controller.dart';

class LoginPage extends StatefulWidget {
  static const routeName = "/login";

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final loginController = Modular.get<LoginController>();
  final userController = Modular.get<UserController>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passControleer = TextEditingController();
  String userName;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('My Annoteds')),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
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
                child: TextFormField(
                  controller: nameController,
                  onChanged: (valor) =>
                      setState(() => userName = valor.trim().toLowerCase()),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Usuário',
                  ),
                  validator: (String submittedValue) {
                    if (submittedValue.isEmpty) {
                      return 'Este campo não pode ser vazio!';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: passControleer,
                  onChanged: (valor) => setState(() => password = valor),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Senha',
                  ),
                  validator: (String submittedValue) {
                    if (submittedValue.isEmpty) {
                      return 'Este campo não pode ser vazio!';
                    }
                    return null;
                  },
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
                    if (_formKey.currentState.validate()) {
                      loginController.signIn(context: context, name: userName, password: password);
                      userController.saveLoggedUser(name: userName);
                    }
                  },
                ),
              ),
              SizedBox(height: 7),
              FlatButton(
                onPressed: () {
                  Modular.link.pushNamed(SignUpPage.routeName);
                },
                child: Text('Não é cadastrado? Cadastre-se aqui!',
                    style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
