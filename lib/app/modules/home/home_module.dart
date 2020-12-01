import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/modules/home/home_controller.dart';
import 'package:my_anoteds/app/modules/home/view/crud_postit_page.dart';
import 'home_page.dart';
import 'model/postit.dart';
import 'model/user.dart';

class HomeModule extends ChildModule {
  @override
  // TODO: implement binds
  List<Bind> get binds => [
    Bind((i) => HomeController()),
    Bind((i) => User(postits: new List<Postit>())),
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
      child: (_, args) => CrudPostitPage(),
      transition: TransitionType.fadeIn,
    ),
  ];

  static Inject get to => Inject<HomeModule>.of();
}
