import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_anoteds/app/modules/home/home_controller.dart';
import 'package:my_anoteds/app/modules/home/model/postit_color.dart';
import 'package:my_anoteds/app/modules/home/view/crud_postit_page.dart';

import 'model/user.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Modular.get<HomeController>();
  final User user = Modular.get<User>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("My anoteds"),
          centerTitle: true,
        ),
        body: Consumer<User>(builder: (context, value) {
          return StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            itemCount: user.postits.length,
            itemBuilder: (BuildContext context, int index) => PostitWidget(
              index: index,
            ),
            staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          );
        }),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Modular.to.pushNamed(CrudPostitPage.routeName);
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
    return Container(
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
            Divider(thickness: 2,color: Colors.black,),
            Container(
              child: Text(user.postits[index].description),
            ),
          ],
        ));
  }
}
