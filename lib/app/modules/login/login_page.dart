import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/modules/login/view/signup_page.dart';

import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  static const routeName = "/";

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final loginController = Modular.get<LoginController>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passControleer = TextEditingController();
  String userName;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('My Annoteds')),
        backgroundColor: Colors.amber,
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
                          color: Colors.amber,
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
                  color: Colors.amber,
                  child: Text('Entrar'),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      loginController.signin(context: context,userName: userName, password: password);
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
