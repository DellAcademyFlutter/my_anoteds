import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/controller/user_controller.dart';
import 'package:my_anoteds/app/model/user.dart';
import 'package:my_anoteds/app/modules/home/view/crud_marker_page.dart';
import 'package:my_anoteds/app/modules/home/view/user_settings_page.dart';

import '../home_controller.dart';

class SideMenuWidget extends StatelessWidget {
  final homeController = Modular.get<HomeController>();
  final userController = Modular.get<UserController>();
  final loggedUser = Modular.get<User>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.filter, size: 80),
                  Text('MyAnnoteds'),
                ],
              ),
            ),
          ),
          ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configurações'),
              onTap: () {
                Modular.to.pop();
                Modular.link.pushNamed(UserSettingsPage.routeName);
              }),
          ListTile(
            leading: Icon(Icons.bookmarks_sharp),
            title: Text('Tags'),
            onTap: () {
              Modular.to.pop();
              Modular.link.pushNamed(CrudMarkerPage.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sair'),
            onTap: () {
              Modular.to.pop();
              userController.deleteLoggedUser(name: loggedUser.name);
              homeController.Logout();
            },
          )
        ],
      ),
    );
  }
}
