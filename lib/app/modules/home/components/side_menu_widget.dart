import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/modules/home/view/crud_marker_page.dart';
import 'package:my_anoteds/app/modules/home/view/user_settings_page.dart';

import '../home_controller.dart';

class SideMenuWidget extends StatelessWidget {
  final homeController = Modular.get<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: null,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        "https://vdmedia.elpais.com/elpaistop/20202/29/2019121992148149_1582990136_asset_still.png"))),
          ),
          ListTile(
              leading: Icon(Icons.settings),
              title: Text('configurações'),
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
              homeController.Logout();
            },
          )
        ],
      ),
    );
  }
}
