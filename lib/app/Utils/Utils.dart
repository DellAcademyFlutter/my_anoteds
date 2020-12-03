import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utils {
  static showAlertDialog(BuildContext context, String title, String message, String buttonConfirmationLabel) {
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
}