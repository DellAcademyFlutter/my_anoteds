import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/Utils/math_utils.dart';
import 'package:my_anoteds/app/repositories/shared/themes/AppThemes.dart';
import 'package:my_anoteds/app/repositories/shared/user_settings.dart';

class UserSettingsPage extends StatelessWidget {
  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Configurações'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: ListView(
          children: [
            LightDarkTheme(),
            TextSize(),
          ],
        ),
      ),
    );
  }
}

/// Esta classe retorna um widget referente a configuracao de tema escuro ou claro.
class LightDarkTheme extends StatefulWidget {
  @override
  LightDarkThemeState createState() => LightDarkThemeState();
}

/// Esta classe retorna um widget referente ao estado da configuracao de tema escuro ou claro.
class LightDarkThemeState extends State<LightDarkTheme> {
  final settings = Modular.get<UserSettings>();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Tema'),
        trailing: LightDarkThemeDropDownButton(),
      ),
    );
  }
}

/// Esta classe retorna um widget de dropdown de menu escuro ou claro.
class LightDarkThemeDropDownButton extends StatefulWidget {
  LightDarkThemeDropDownButton({Key key}) : super(key: key);

  @override
  LightDarkThemeDropDownButtonState createState() =>
      LightDarkThemeDropDownButtonState();
}

/// Esta classe retorna um widget de dropdown de menu escuro ou claro.
class LightDarkThemeDropDownButtonState
    extends State<LightDarkThemeDropDownButton> {
  List<String> values = [
    'Sistema',
    'Tema Claro',
    'Tema Escuro',
    'Alto contraste'
  ];
  String dropdownValue = 'Sistema';
  final settings = Modular.get<UserSettings>();

  @override
  Widget build(BuildContext context) {
    return Consumer<UserSettings>(
      builder: (context, value) {
        return DropdownButton<String>(
          value: dropdownValue, //"settings.themeDescription,
          icon: Icon(Icons.more_vert),
          iconSize: 24,
          elevation: 16,
          underline: Container(
            height: 2,
          ),
          onChanged: (String newValue) {
            setState(() {
              dropdownValue = newValue;
              AppThemesEnum theme;
              switch (newValue) {
                case 'Sistema':
                  theme = AppThemesEnum.system;
                  break;
                case 'Tema Escuro':
                  theme = AppThemesEnum.darkTheme;
                  break;
                case 'Alto contraste':
                  theme = AppThemesEnum.highContrast;
                  break;
                default:
                  theme = AppThemesEnum.lightTheme;
                  break;
              }
              settings.changeTheme(theme: theme, context: context);
            });
          },
          items: values.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        );
      },
    );
  }
}

/// Esta classe retorna um widget referente a configuracao do tamanho da fonte.
class TextSize extends StatelessWidget {
  final settings = Modular.get<UserSettings>();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                'Tamanho da fonte',
              ),
            ),
            Container(child: TextSizeSlider()),
          ],
        ),
      ),
    );
  }
}

/// Esta classe retorna um widget com slider referente ao tamanho da fonte.
class TextSizeSlider extends StatelessWidget {
  final settings = Modular.get<UserSettings>();

  @override
  Widget build(BuildContext context) {
    return Consumer<UserSettings>(
      builder: (context, value) {
        return Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Theme.of(context).cardColor.withOpacity(0),
                inactiveTrackColor: Theme.of(context).cardColor.withOpacity(0),
                trackHeight: 14,
                trackShape: RoundedRectSliderTrackShape(),
                tickMarkShape: RoundSliderTickMarkShape(),
                activeTickMarkColor: Theme.of(context).accentColor,
                inactiveTickMarkColor: Theme.of(context).accentColor,
              ),
              child: Slider(
                value: settings.fontSize,
                min: 14,
                max: 25,
                divisions: 6,
                label:
                    "${MathUtils.round(number: settings.fontSize, decimalPlaces: 0)}",
                onChanged: (newSliderValue) {
                  settings.fontSize = newSliderValue;
                },
              ),
            ),
            RaisedButton(
              child: Text('Tamanho padrão'),
              onPressed: settings.fontSize == settings.defaultFontSize
                  ? null
                  : () {
                      settings.fontSize = settings.defaultFontSize;
                    },
            )
          ],
        ));
      },
    );
  }
}
