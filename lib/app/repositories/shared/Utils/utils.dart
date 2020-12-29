import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class Utils {
  static showAlertDialog(BuildContext context, String title, String message,
      String buttonConfirmationLabel) {
    // exibe o dialog
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              FlatButton(
                child: Text(buttonConfirmationLabel),
                onPressed: () {
                  Modular.to.pop();
                },
              ),
            ],
          );
        });
  }

  /// Este metodo remove o focus de um widget.
  static removeFocus({BuildContext context}) {
    final currentFocus = FocusScope.of(context);

    // Remove o focus do widget atual
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  /// Este metodo retorna uma string capitalizada.
  static String captalize(String str) {
    return "${str[0].toUpperCase()}${str.substring(1)}";
  }
}
