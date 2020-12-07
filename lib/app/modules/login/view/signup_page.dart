import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:my_anoteds/app/Utils/validator_fields.dart';
import 'package:my_anoteds/app/controller/user_controller.dart';

class SignUpPage extends StatefulWidget {
  static const routeName = "/signin";
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String name, pass, email, birth;
  var maskFormatter = new MaskTextInputFormatter(
      mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController birthController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  AutovalidateMode isValidating = AutovalidateMode.disabled;

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
          autovalidateMode: isValidating,
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
                child: TextFormField(
                  controller: nameController,
                  onChanged: (valor) =>
                      setState(() => name = valor.trim().toLowerCase()),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nome de usuário',
                  ),
                  validator: (String submittedValue) {
                    if (submittedValue.isEmpty) {
                      return 'Nome de usuário não pode ser vazio!';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: passController,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  onChanged: (valor) => setState(() => pass = valor),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Senha',
                  ),
                  validator: (String submittedValue) {
                    if (submittedValue.isEmpty) {
                      return 'O campo senha não pode ser vazio!';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: birthController,
                  inputFormatters: [maskFormatter],
                  onChanged: (valor) => setState(() => birth = valor),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Data de nascimento',
                  ),
                  validator: (String submittedValue) {
                    final bool dateValidator =
                        Validator.validateDate(submittedValue);
                    if (!dateValidator) {
                      return 'Data inválida!';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: emailController,
                  onChanged: (valor) => setState(() => email = valor),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  validator: (String submittedValue) {
                    final bool emailValidator =
                        Validator.validateEmail(submittedValue);
                    if (!emailValidator) {
                      return 'Email inválido!';
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
                  child: Text('Cadastrar'),
                  onPressed: () {
                    isValidating = AutovalidateMode.always;
                    if (_formKey.currentState.validate()) {
                      UserController.saveUser(
                          name: name, pass: pass, email: email, birth: birth);
                      Modular.to.pop();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
