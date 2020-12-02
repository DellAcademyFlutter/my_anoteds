import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_anoteds/app/modules/home/model/postit_color.dart';
import 'package:my_anoteds/app/modules/home/view/crud_postit_page.dart';
import 'data/postit_dao.dart';
import 'home_controller.dart';
import 'model/postit.dart';
import 'model/user.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Modular.get<HomeController>();
  final postitDao = Modular.get<PostitDao>();
  final User user = Modular.get<User>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text("My anoteds", style: TextStyle(color: Colors.black)),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: postitDao.getPostits(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Postit>> snapshot) {
            return snapshot.hasData
                ? Consumer<User>(builder: (context, value) {
                user.postits = snapshot.data;
              return StaggeredGridView.countBuilder(
                crossAxisCount: 4,
                itemCount: user.postits.length,
                itemBuilder: (BuildContext context, int index) =>
                    PostitWidget(
                      index: index,
                    ),
                staggeredTileBuilder: (int index) =>
                (user.postits[index].description.length > 120) || user.postits[index].description.contains('\n')?
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
            Modular.to.pushNamed(CrudPostitPage.routeName,
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
        Modular.to.pushNamed(CrudPostitPage.routeName,
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

        // ignore: missing_return
        confirmDismiss: (direction) async {
          final bool resp = await showAlertDialog(context, index);
          return resp;
        }
      ),
    );
  }
}

showAlertDialog(BuildContext context, int index) {
  final controller = Modular.get<HomeController>();
  final User user = Modular.get<User>();

  final Widget cancelButton = FlatButton(
    child: Text("Nao"),
    onPressed: () => Navigator.of(context).pop(),
  );
  final Widget continueButton = FlatButton(
      child: Text("Sim"),
      onPressed: () {
        controller.removePostit(index: index);
        Navigator.of(context).pop();
      });

  final AlertDialog alert = AlertDialog(
    title: Text("Atencão!"),
    content: Text("Deseja remover o Post-it: ${user.postits[index].title}?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}