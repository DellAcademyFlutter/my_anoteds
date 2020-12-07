import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_anoteds/app/data/postit_dao.dart';
import 'package:my_anoteds/app/model/postit.dart';
import 'package:my_anoteds/app/model/postit_color.dart';
import 'package:my_anoteds/app/model/user.dart';
import 'package:my_anoteds/app/modules/home/view/crud_postit_page.dart';
import 'package:my_anoteds/app/modules/home/view/user_settings_page.dart';
import 'package:my_anoteds/app/modules/login/login_page.dart';


class HomePage extends StatefulWidget {
  static const routeName = "/home";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final postitDao = Modular.get<PostitDao>();
  final User loggedUser = Modular.get();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: SideMenu(),
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text("My annoteds of: ${loggedUser.name}", style: TextStyle(color: Colors.black)),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: postitDao.getPostits(loggedUser.id),
          builder:
              (BuildContext context, AsyncSnapshot<List<Postit>> snapshot) {
            return snapshot.hasData
                ? Consumer<User>(builder: (context, value) {
                loggedUser.postits = snapshot.data;
              return StaggeredGridView.countBuilder(
                crossAxisCount: 4,
                itemCount: loggedUser.postits.length,
                itemBuilder: (BuildContext context, int index) =>
                    PostitWidget(
                      index: index,
                    ),
                staggeredTileBuilder: (int index) =>
                (loggedUser.postits[index].description.length > 120) || loggedUser.postits[index].description.contains('\n')?
                StaggeredTile.fit(2) : StaggeredTile.count(2,2),
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
              );
            })
                : CircularProgressIndicator();
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.black),
          backgroundColor: Colors.amber,
          onPressed: () {
            Modular.link.pushNamed(CrudPostitPage.routeName,
                arguments: CrudPostitPageArguments(postit: null));
          },
        ),
      ),
    );
  }
}

class PostitWidget extends StatelessWidget {
  PostitWidget({this.index});

  final int index;
  final User user = Modular.get<User>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Modular.link.pushNamed(CrudPostitPage.routeName,
            arguments: CrudPostitPageArguments(postit: user.postits[index]));
      },
      child: Dismissible(
        key: UniqueKey(),
        child: Card(
          color: Colors.grey,
          child: Container(
              color: Color(PostitColor.colors[user.postits[index].color]),
              child: Column(
                children: [
                  SizedBox(height: 8),
                  Container(
                    child: Text(
                      user.postits[index].title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(user.postits[index].description),
                  ),
                ],
              )),
        ),

      ),
    );
  }
}

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Center(child: Text('Anote App!')),
          ),
          ListTile(
              leading: Icon(Icons.settings),
              title: Text('configurações'),
              onTap: () {
                Modular.to.pop();
                Modular.link.pushNamed(UserSettingsPage.routeName);
              }),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sair'),
            onTap: () {
              Modular.to.pop();
              Logout();
            },
          )
        ],
      ),
    );
  }
}

Logout() {
  final loggedUser = Modular.get<User>();
  final User nullUser = User(
      id: null,
      name: null,
      password: null,
      email: null,
      birth: null,
      postits: null);
  loggedUser.setValues(otherUser: nullUser);
  Modular.to.pushReplacementNamed(LoginPage.routeName);
}
