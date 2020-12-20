import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/model/postit.dart';
import 'package:my_anoteds/app/model/user.dart';
import 'package:my_anoteds/app/repositories/local/LocalNotification/local_notification.dart';
import 'package:my_anoteds/app/repositories/local/LocalNotification/timeZoneHelper.dart';
import 'package:my_anoteds/app/repositories/shared/Utils/utils.dart';

/// Lembre-se de configurar o local do seu emulador para Sao Paulo;
/// Settings -> System -> Date & Time -> Time Zone
/// Region: Escolha Brazil,
/// Time Zone: Escolha Sao Paulo
class ReminderPageArguments {
  ReminderPageArguments({this.postit});
  final Postit postit;
}

class ReminderPage extends StatefulWidget {
  static const routeName = "/reminder";

  ReminderPage({this.postit});
  final Postit postit;

  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  final loggedUser = Modular.get<User>();
  TimeOfDay time;
  int selectedDay;
  List<int> days = [
    DateTime.monday,
    DateTime.tuesday,
    DateTime.wednesday,
    DateTime.thursday,
    DateTime.friday,
    DateTime.saturday,
    DateTime.sunday,
  ];

  @override
  void initState() {
    super.initState();
    time = TimeOfDay.now();
    selectedDay = days[TimeZoneHelper.getToday()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marque um lembrete!'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              title: Text("Escolha uma hora: ${time.hour}:${time.minute}"),
              trailing: Icon(Icons.keyboard_arrow_down),
              onTap: _pickTime,
            ),
            ListTile(
              title: Text("Escolha um dia:"),
              trailing: DropdownButton<int>(
                value: selectedDay,
                icon: Icon(Icons.more_vert),
                iconSize: 24,
                elevation: 16,
                underline: Container(
                  height: 2,
                ),
                onChanged: (int newValue) {
                  setState(() {
                    selectedDay = newValue;
                  });
                },
                items: days.map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(_getStringDay(value)),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          tooltip: "Salvar lembrete",
          child: Icon(Icons.save),
          onPressed: _saveReminder),
    );
  }

  /// Faz o Pick do time selecionado.
  _pickTime() async {
    final t = await showTimePicker(context: context, initialTime: time);
    if (t != null)
      setState(() {
        time = t;
      });
  }

  _saveReminder() async {
    final title = 'Lembrete MyAnoteds!';
    final body =
        '${Utils.captalize(loggedUser.name)}, lembre-se de seu postit: ${widget.postit.title}';
    final dialogTitle = "Lembrete!";
    final now = TimeOfDay.now();
    var dialogMessage =
        "Seu postit será lembrado em ${time.hour}:${time.minute} no(a) próximo(a) ${_getStringDay(selectedDay)}";

    if (selectedDay == days[TimeZoneHelper.getToday()] &&
        now.hour <= time.hour &&
        now.minute < time.minute) {
      dialogMessage =
          "Seu postit será lembrado hoje em ${time.hour}:${time.minute}";
    }

    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(dialogTitle),
            content: Text(dialogMessage),
            actions: [
              FlatButton(
                child: Text("Ok!"),
                onPressed: () {
                  Modular.to.pop();
                },
              ),
            ],
          );
        });

    await LocalNotification.scheduleNotificationForDay(
        id: widget.postit.id,
        title: title,
        body: body,
        day: selectedDay,
        hour: time.hour,
        minute: time.minute);

    Modular.to.pop();
  }

  String _getStringDay(int day) {
    switch (day) {
      case 1:
        return "segunda";
        break;
      case 2:
        return "terça";
        break;
      case 3:
        return "quarta";
        break;
      case 4:
        return "quinta";
        break;
      case 5:
        return "sexta";
        break;
      case 6:
        return "sábado";
        break;
      default:
        return "domingo";
        break;
    }
  }
}
