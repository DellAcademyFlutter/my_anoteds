import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/modules/home/data/users_dao.dart';
import 'package:my_anoteds/app/modules/home/view/login_page.dart';
import 'package:my_anoteds/app/modules/home/view/signin_page.dart';
import 'data/postit_dao.dart';
import 'package:my_anoteds/app/modules/home/view/crud_postit_page.dart';
import 'home_controller.dart';
import 'home_page.dart';
import 'model/postit.dart';
import 'model/user.dart';

class HomeModule extends ChildModule {
  @override
  // TODO: implement binds
  List<Bind> get binds => [
    Bind((i) => SignInPage()),
    Bind((i) => LoginPage()),
    Bind((i) => HomeController()),
    Bind((i) => User(postits: List<Postit>())),
    Bind((i) => PostitDao()),
    Bind((i) => UserDao()),
  ];

  @override
  // TODO: implement routers
  List<ModularRouter> get routers => [
    ModularRouter(
      LoginPage.routeName,
      child: (_, args) => LoginPage(),
      transition: TransitionType.leftToRightWithFade,
    ),
    ModularRouter(
      HomePage.routeName,
      child: (_, args) => HomePage(),
      transition: TransitionType.leftToRightWithFade,
    ),
    ModularRouter(
      CrudPostitPage.routeName,
      child: (_, args) => CrudPostitPage(postit: args.data.postit,),
      transition: TransitionType.fadeIn,
    ),
    ModularRouter(
      SignInPage.routeName,
      child: (_, args) => SignInPage(),
      transition: TransitionType.fadeIn,
    ),
  ];

//static Inject get to => Inject<HomeModule>.of();
}
