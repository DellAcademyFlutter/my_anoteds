import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/modules/home/data/users_dao.dart';
import 'package:my_anoteds/app/modules/home/view/signin_page.dart';
import 'login_page.dart';

class LoginModule extends ChildModule {
  @override
  // TODO: implement binds
  List<Bind> get binds => [
    Bind((i) => SignInPage()),
    Bind((i) => LoginPage()),
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
      LoginPage.routeName,
      child: (_, args) => SignInPage(),
      transition: TransitionType.leftToRightWithFade,
    ),
  ];

//static Inject get to => Inject<HomeModule>.of();
}
