import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class Utils {
  static showAlertDialog(BuildContext context, String title, String message,
      String buttonConfirmationLabel) {
    // configura o button
    final Widget okButton = FlatButton(
      child: Text(buttonConfirmationLabel),
      onPressed: () {
        Modular.to.pop();
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
}

/// Este metodo remove o focus de um widget.
removeFocus({BuildContext context}) {
  final FocusScopeNode currentFocus = FocusScope.of(context);

  // Remove o focus do widget atual
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}