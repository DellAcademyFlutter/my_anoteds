import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_anoteds/app/modules/home/controller/home_controller.dart';
import 'package:my_anoteds/app/modules/home/data/postit_dao.dart';
import 'package:my_anoteds/app/modules/home/model/postit_color.dart';
import 'package:my_anoteds/app/modules/home/view/crud_postit_page.dart';

import 'model/postit.dart';
import 'model/user.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Modular.get<HomeController>();
  final user = Modular.get<User>();
  final postitDao = Modular.get<PostitDao>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("My anoteds"),
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
                staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
              );
            })
                : CircularProgressIndicator();
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
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
  final user = Modular.get<User>();
  final controller = Modular.get<HomeController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Modular.to.pushNamed(CrudPostitPage.routeName,
            arguments: CrudPostitPageArguments(postit: user.postits[index]));
      },
      child: Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          controller.removePostit(index: index);
        },
        child: Container(
            margin: const EdgeInsets.all(15.0),
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: Color(PostitColor.colors[user.postits[index].color])),
            child: Column(
              children: [
                Container(
                  child: Text(
                    user.postits[index].title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(
                  thickness: 2,
                  color: Colors.black,
                ),
                Container(
                  child: Text(user.postits[index].description),
                ),
              ],
            )),
      ),
    );
  }
}
