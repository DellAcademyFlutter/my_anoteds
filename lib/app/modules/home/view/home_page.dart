import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_anoteds/app/controller/postit_controller.dart';
import 'package:my_anoteds/app/data/postit_dao.dart';
import 'package:my_anoteds/app/model/user.dart';
import 'package:my_anoteds/app/modules/home/components/marker_filter_row_widget.dart';
import 'package:my_anoteds/app/modules/home/components/postit_widget.dart';
import 'package:my_anoteds/app/modules/home/components/side_menu_widget.dart';

import '../home_controller.dart';
import 'crud_postit_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/home";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final postitController = Modular.get<PostitController>();
  final homeController = Modular.get<HomeController>();
  final loggedUser = Modular.get<User>();
  final postitDao = Modular.get<PostitDao>();

  @override
  void initState() {
    super.initState();

    homeController.initializeLoggedUserPostits(loggedUser: loggedUser);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: SideMenuWidget(),
        appBar: AppBar(
          title: Text("Anotadas de ${loggedUser.name ?? ""}"),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 50, child: MarkerFilterRowWidget()),
            Expanded(
              child: SizedBox(
                  height: 200,
                  child: Consumer<User>(builder: (context, value) {
                    return loggedUser.postits != null
                        ? StaggeredGridView.countBuilder(
                            crossAxisCount: 4,
                            itemCount: loggedUser.postits.length,
                            itemBuilder: (BuildContext context, int index) =>
                                PostitWidget(
                              index: index,
                            ),
                            staggeredTileBuilder: (int index) =>
                                StaggeredTile.fit(2),
                            mainAxisSpacing: 4.0,
                            crossAxisSpacing: 4.0,
                          )
                        : CircularProgressIndicator();
                  })),
            ),
          ],
        ),

        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Modular.link.pushNamed(CrudPostitPage.routeName,
                arguments: CrudPostitPageArguments(postit: null));
          },
        ),

        //bottomNavigationBar:  PopupMenuWidget(),
      ),
    );
  }
}
