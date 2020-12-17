import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/controller/user_controller.dart';
import 'package:my_anoteds/app/data/users_dao.dart';
import 'package:my_anoteds/app/model/user.dart';
import 'package:my_anoteds/app/modules/home/view/home_page.dart';
import 'package:my_anoteds/app/modules/login/view/login_page.dart';

class SplashPage extends StatefulWidget {
  static const routeName = "/";

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final userController = Modular.get<UserController>();
  final loggedUser = Modular.get<User>();
  User user;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      runInitTasks(context); // initState aceita o context
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Icon(
                  Icons.bookmark,
                  size: 200,
                ),
                Text('My Anoteds'),
                SizedBox(
                  height: 20,
                ),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  backgroundColor: Colors.grey,
                ),
                Text(
                  'Carregando...',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future runInitTasks(BuildContext context) async {
    final userDao = Modular.get<UserDao>();
    await userDao.getLoggedUser().then((value) {
      user = value;

      if (value == null) {
        Timer(Duration(seconds: 1), () {
          Modular.to.pushReplacementNamed(LoginPage.routeName);
        });
      } else {
        loggedUser.setValues(otherUser: value);
        Timer(Duration(seconds: 1), () {
          Modular.to.pushReplacementNamed(HomePage.routeName);
        });
      }
    });
  }
}
