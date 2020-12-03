import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/controller/user_controller.dart';
import '../login_page.dart';

class SignUpPage extends StatefulWidget {
  static const routeName = "/signin";
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController birthController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String name;
  String pass;
  String email;
  String birth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('My Annoteds')),
        backgroundColor: Colors.amber,
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
                    'Cadastrar usuário',
                    style: TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  ),
                )),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                onChanged: (valor) =>
                    setState(() => name = valor.trim().toLowerCase()),
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
                controller: passController,
                onChanged: (valor) => setState(() => pass = valor),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Senha',
                ),
              ),
            ),
            SizedBox(height: 5),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: birthController,
                
                onChanged: (valor) => setState(() => birth = valor),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Aniversário',
                ),
              ),
            ),
            SizedBox(height: 5),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: emailController,
                onChanged: (valor) => setState(() => email = valor),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            SizedBox(height: 5),
            Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: RaisedButton(
                textColor: Colors.black,
                color: Colors.amber,
                child: Text('Cadastrar'),
                onPressed: () {
                  if (nameController.text == '' ||
                      passController.text == '' ||
                      birthController.text == '' ||
                      emailController.text == '') {
                    showAlertDialog(context, "Os campos não podem ser vazios","Alerta","OK");
                  } else {
                    UserController.saveUser(
                        name: name, pass: pass, email: email, birth: birth);
                    Modular.to.pushReplacementNamed(LoginPage.routeName);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context, String title, String message, String buttonConfirmationLabel) {
  // configura o button
  final Widget okButton = FlatButton(
    child: Text(buttonConfirmationLabel),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // configura o  AlertDialog
  final AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      okButton,
    ],
  );

  // exibe o dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

/// Este metodo remove o focus de um widget.
removeFocus({BuildContext context}) {
  final FocusScopeNode currentFocus = FocusScope.of(context);

  // Remove o focus do widget atual
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

