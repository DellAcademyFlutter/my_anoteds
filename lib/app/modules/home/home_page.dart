import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_anoteds/app/Utils/image_picker_utils.dart';
import 'package:my_anoteds/app/controller/postit_controller.dart';
import 'package:my_anoteds/app/data/marker.dao.dart';
import 'package:my_anoteds/app/data/postit_dao.dart';
import 'package:my_anoteds/app/model/marker.dart';
import 'package:my_anoteds/app/model/postit.dart';
import 'package:my_anoteds/app/model/postit_color.dart';
import 'package:my_anoteds/app/model/user.dart';
import 'package:my_anoteds/app/modules/home/view/crud_postit_page.dart';
import 'package:my_anoteds/app/modules/home/view/markers_page.dart';
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
          title: Text("My annoteds of: ${loggedUser.name}",
              style: TextStyle(color: Colors.black)),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 50, child: markers()),
            Expanded(
              child: SizedBox(
                height: 200.0,
                child: FutureBuilder(
                  future: postitDao.getPostits(loggedUser.id),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Postit>> snapshot) {
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
                              staggeredTileBuilder: (int index) => (loggedUser
                                              .postits[index]
                                              .description
                                              .length >
                                          120) ||
                                      loggedUser.postits[index].description
                                          .contains('\n')
                                  ? StaggeredTile.fit(2)
                                  : StaggeredTile.count(2, 2),
                              mainAxisSpacing: 4.0,
                              crossAxisSpacing: 4.0,
                            );
                          })
                        : CircularProgressIndicator();
                  },
                ),
              ),
            ),
          ],
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
  final controllerPostit = Modular.get<PostitController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Modular.link.pushNamed(CrudPostitPage.routeName,
            arguments: CrudPostitPageArguments(postit: user.postits[index]));
      },
      child: Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          controllerPostit.removePostit(index: index);
        },
        child: Card(
          color: Colors.grey,
          child: Container(
              color:
                  Color(PostitColor.colors[user.postits[index].color]['hex']),
              child: Column(
                children: [
                  SizedBox(height: 8),
                  Container(
                    child: Text(
                      user.postits[index].title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: (user.postits[index].color == "verde" ||
                                  user.postits[index].color == "azul")
                              ? Colors.white
                              : Colors.black),
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.black,
                  ),
                  Container(
                    child: user.postits[index].image != null
                        ? Image.memory(
                            ImagePickerUtils.getBytesImage(
                                base64Image: user.postits[index].image),
                            width: 20,
                            height: 20,
                          )
                        : null,
                  ),
                  //Divider(),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      user.postits[index].description,
                      style: TextStyle(
                          color: (user.postits[index].color == "verde" ||
                                  user.postits[index].color == "azul")
                              ? Colors.white
                              : Colors.black),
                    ),
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
              Modular.link.pushNamed(MarkersPage.routeName);
            },
          ),
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
  final nullUser = User(
      id: null,
      name: null,
      password: null,
      email: null,
      birth: null,
      postits: null);
  loggedUser.setValues(otherUser: nullUser);
  Modular.to.pushReplacementNamed(LoginPage.routeName);
}

Widget markers() {
  final loggedUser = Modular.get<User>();
  final markerDao = Modular.get<MarkerDao>();

  return FutureBuilder(
      future: markerDao.getMarkers(loggedUser.id),
      builder: (BuildContext context, AsyncSnapshot<List<Marker>> snapshot) {
        return snapshot.hasData
            ? Consumer<User>(builder: (context, value) {
                loggedUser.markers = snapshot.data;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: loggedUser.markers.length,
                  itemBuilder: (BuildContext context, int index) =>
                      markersListFilter(index),
                );
              })
            : CircularProgressIndicator();
      });
}

class markersListFilter extends StatefulWidget {
  final int index;

  markersListFilter(this.index);

  @override
  _markersListFilterState createState() => _markersListFilterState();
}

class _markersListFilterState extends State<markersListFilter> {
  final loggedUser = Modular.get<User>();
  Color cor = Colors.transparent;
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          FlatButton(
            textColor: Colors.black,
            color: cor,
            onPressed: () {
              setState(() {
                if (cor == Colors.transparent) {
                  cor = Colors.greenAccent;
                  //loggedUser.addFilter(widget.index);
                   isActive = true;
                } else {
                  cor = Colors.transparent;
                  isActive = false;
                }
              });
            },
            child: Text(loggedUser.markers[widget.index].title),
          ),
          SizedBox(width: 5),
        ],
      ),
    );
  }
}
