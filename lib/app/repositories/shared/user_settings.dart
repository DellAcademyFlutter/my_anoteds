import 'package:flutter/cupertino.dart';
import 'package:my_anoteds/app/repositories/shared/themes/AppThemes.dart';


class UserSettings extends ChangeNotifier{
  // Atributos da classe
  AppThemesEnum _userTheme = AppThemesEnum.system;
  double _fontSize = 19.5;
  final double defaultFontSize = 19.5;

  // Construtor da classe
  UserSettings();

  // Metodos da classe
  changeTheme({AppThemesEnum theme, BuildContext context}) {
    // Escolha sistema
    if (theme == AppThemesEnum.system) {
      // Primeiro verifica alto contraste
      (MediaQuery.of(context).highContrast == true)
          ? userTheme = AppThemesEnum.highContrast
          :
      // Depois verifica claro/escuro
      (MediaQuery.platformBrightnessOf(context) == Brightness.light)
          ? userTheme = AppThemesEnum.lightTheme
          : userTheme = AppThemesEnum.darkTheme;
      return;
    }

    userTheme = theme;
  }

  // Gets e Sets
  AppThemesEnum get userTheme => _userTheme;

  set userTheme(AppThemesEnum value) {
    _userTheme = value;
    notifyListeners();
  }

  double get fontSize => _fontSize;
  set fontSize(double value) {
    _fontSize = value;
    notifyListeners();
  }
}
