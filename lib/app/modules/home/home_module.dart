import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/modules/home/view/crud_postit_page.dart';
import 'package:my_anoteds/app/modules/home/view/markers_page.dart';
import 'package:my_anoteds/app/modules/home/view/user_settings_page.dart';
import 'home_controller.dart';
import 'home_page.dart';

class HomeModule extends ChildModule {
  @override
  // TODO: implement binds
  List<Bind> get binds => [
    Bind((i) => HomeController()),
  ];

  @override
  // TODO: implement routers
  List<ModularRouter> get routers => [
    ModularRouter(
      HomePage.routeName,
      child: (_, args) => HomePage(),
      transition: TransitionType.leftToRightWithFade,
    ),
    ModularRouter(
      CrudPostitPage.routeName,
      child: (_, args) => CrudPostitPage(postit: args.data.postit),
      transition: TransitionType.scale,
    ),
    ModularRouter(
      UserSettingsPage.routeName,
      child: (_, args) => UserSettingsPage(),
    ),
    ModularRouter(
      MarkersPage.routeName,
      child: (_, args) => MarkersPage(),
      transition: TransitionType.leftToRightWithFade,
    ),
  ];

   static Inject get to => Inject<HomeModule>.of();
}
