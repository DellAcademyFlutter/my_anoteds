import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/repositories/shared/user_settings.dart';

enum AppThemesEnum { lightTheme, darkTheme, highContrast, system }

class ThemeCollection {
  /// Obtem o tema do usuario
  static ThemeData getAppTheme() {
    final settings = Modular.get<UserSettings>();

    switch (settings.userTheme) {
      case AppThemesEnum.darkTheme:
        return ThemeCollection.darkTheme();
        break;
      case AppThemesEnum.highContrast:
        return ThemeCollection.highContrastTheme();
        break;
      default:
        return ThemeCollection.defaultTheme();
        break;
    }
  }

  static defaultTheme() {
    final settings = Modular.get<UserSettings>();

    return ThemeData(
      scaffoldBackgroundColor: Colors.blueGrey[100],
      appBarTheme: AppBarTheme(
        textTheme: TextTheme(
          headline6: TextStyle(
              fontSize: (settings.fontSize),
              color: Colors.black87,
              fontWeight: FontWeight.bold),
        ),
        color: Colors.blue,
      ),
      brightness: Brightness.light,
      cardColor: Colors.grey[300],
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(),
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: TextTheme(
          headline5: TextStyle(color: Colors.green),
          headline6: TextStyle(
              fontSize: (settings.fontSize),
              color: Colors.black87,
              fontWeight: FontWeight.bold),
          bodyText2: TextStyle(
              fontSize: (settings.fontSize),
              color: Colors.black87,
              fontWeight: FontWeight.bold),
          subtitle1: TextStyle(
              fontSize: (settings.fontSize),
              color: Colors.black87,
              fontWeight: FontWeight.bold),
          subtitle2: TextStyle(
            fontSize: (settings.fontSize - 5),
            color: Colors.black54,
          ),
          caption: TextStyle(
            fontSize: (settings.fontSize - 5),
            color: Colors.black54,
          )),
    );
  }

  static darkTheme() {
    final settings = Modular.get<UserSettings>();

    return ThemeData(
      appBarTheme: AppBarTheme(
        textTheme: TextTheme(
          headline6: TextStyle(
              fontSize: (settings.fontSize),
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
        color: Colors.blue,
      ),
      brightness: Brightness.dark,
      cardColor: Colors.white60,
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.blue[900],
        shape: RoundedRectangleBorder(),
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: TextTheme(
          headline5: TextStyle(color: Colors.green),
          headline6: TextStyle(
              fontSize: (settings.fontSize),
              color: Colors.white70,
              fontWeight: FontWeight.bold),
          bodyText2: TextStyle(
              fontSize: (settings.fontSize),
              color: Colors.grey,
              fontWeight: FontWeight.bold),
          subtitle1: TextStyle(
              fontSize: (settings.fontSize),
              color: Colors.white70,
              fontWeight: FontWeight.bold),
          subtitle2: TextStyle(
            fontSize: (settings.fontSize - 5),
            color: Colors.white70,
          ),
          caption: TextStyle(
            fontSize: (settings.fontSize - 5),
            color: Colors.white60,
          )),
    );
  }

  static highContrastTheme() {
    final settings = Modular.get<UserSettings>();

    return ThemeData(
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            headline6: TextStyle(
                fontSize: (10 + settings.fontSize),
                color: Colors.white70,
                fontWeight: FontWeight.bold),
          ),
          color: Colors.amber,
        ),
        brightness: Brightness.dark,
        cardColor: Colors.black54,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.yellow,
          shape: RoundedRectangleBorder(),
          textTheme: ButtonTextTheme.primary,
        ),
        textTheme: TextTheme(
            headline5: TextStyle(color: Colors.green),
            headline6: TextStyle(
                fontSize: (settings.fontSize),
                color: Colors.black87,
                fontWeight: FontWeight.bold),
            bodyText2: TextStyle(
                fontSize: (settings.fontSize),
                color: Colors.grey,
                fontWeight: FontWeight.bold),
            subtitle1: TextStyle(
                fontSize: (settings.fontSize),
                color: Colors.white70,
                fontWeight: FontWeight.bold),
            subtitle2: TextStyle(
              fontSize: (settings.fontSize - 5),
              color: Colors.white70,
            ),
            caption: TextStyle(
              fontSize: (settings.fontSize - 5),
              color: Colors.white70,
            )));
  }
}
