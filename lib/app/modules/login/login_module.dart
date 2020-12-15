import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/modules/login/login_controller.dart';
import 'package:my_anoteds/app/modules/login/view/login_page.dart';
import 'package:my_anoteds/app/modules/login/view/signup_page.dart';

import '../../app_widget.dart';

class LoginModule extends ChildModule {
  @override
  // TODO: implement binds
  List<Bind> get binds => [
    Bind((i) => LoginController()),
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
      SignUpPage.routeName,
      child: (_, args) => SignUpPage(),
      transition: TransitionType.fadeIn,
    ),
  ];

  Widget get bootstrap => AppWidget();
  static Inject get to => Inject<LoginModule>.of();
}