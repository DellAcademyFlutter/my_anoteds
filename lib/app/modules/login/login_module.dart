import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/modules/login/view/login_page.dart';
import 'package:my_anoteds/app/modules/login/view/signup_page.dart';

import '../../app_widget.dart';

class LoginModule extends ChildModule {
  @override
  // TODO: implement binds
  List<Bind> get binds => [
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

  Widget get bootstrap => AppWidget();
  static Inject get to => Inject<LoginModule>.of();
}