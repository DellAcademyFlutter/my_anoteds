import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_anoteds/app/data/postit_dao.dart';
import 'package:my_anoteds/app/modules/crud_postit/crud_postit_page.dart';
import 'package:my_anoteds/app/modules/home/components/marker_filter_row_widget.dart';
import 'package:my_anoteds/app/modules/home/components/postit_widget.dart';
import 'package:my_anoteds/app/modules/home/components/side_menu_widget.dart';

import '../../app_controller.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/home";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final appController = Modular.get<AppController>();
  final homeController = Modular.get<HomeController>();
  final postitDao = Modular.get<PostitDao>();

  @override
  void initState() {
    super.initState();

    homeController.initializeLoggedUserPostits(
        loggedUser: appController.loggedUser);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: SideMenuWidget(),
        appBar: AppBar(
          title: Text("Anotadas de ${appController.loggedUser.name ?? ""}"),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 50, child: MarkerFilterRowWidget()),
            Expanded(
              child: SizedBox(
                  height: 200,
                  child: Consumer<AppController>(builder: (context, value) {
                    return appController.postits != null
                        ? StaggeredGridView.countBuilder(
                            crossAxisCount: 4,
                            itemCount: appController.postits.length,
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
            Modular.to.pushNamed(CrudPostitPage.routeName,
                arguments: CrudPostitPageArguments(postit: null));
          },
        ),
      ),
    );
  }
}
