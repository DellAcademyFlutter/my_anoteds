import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/modules/login/login_page.dart';
import 'package:my_anoteds/app/modules/login/signin_page.dart';

class LoginModule extends ChildModule {
  @override
  // TODO: implement binds
  List<Bind> get binds => [
    Bind((i) => SignInPage()),
    Bind((i) => LoginPage()),
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
      SignInPage.routeName,
      child: (_, args) => SignInPage(),
      transition: TransitionType.fadeIn,
    ),
  ];

  static Inject get to => Inject<LoginModule>.of();
}