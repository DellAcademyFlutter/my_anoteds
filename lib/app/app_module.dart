import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/app_controller.dart';
import 'package:my_anoteds/app/app_widget.dart';
import 'package:my_anoteds/app/controller/marking_controller.dart';
import 'package:my_anoteds/app/data/marking_dao.dart';
import 'package:my_anoteds/app/modules/login/login_controller.dart';
import 'package:my_anoteds/app/modules/login/login_page.dart';
import 'package:my_anoteds/app/modules/splash/splash_module.dart';
import 'package:my_anoteds/app/modules/splash/splash_page.dart';
import 'package:my_anoteds/app/repositories/shared/user_settings.dart';
import 'controller/marker_controller.dart';
import 'controller/postit_controller.dart';
import 'controller/user_controller.dart';
import 'data/marker_dao.dart';
import 'data/postit_dao.dart';
import 'data/users_dao.dart';
import 'model/user.dart';
import 'modules/home/home_module.dart';
import 'modules/home/home_page.dart';
import 'modules/login/login_module.dart';

class AppModule extends MainModule {
  @override
  // Lista de injecoes de independencia do projeto
  List<Bind> get binds => [
    Bind((i) => AppController()),
    Bind((i) => PostitController()),
    Bind((i) => UserController()),
    Bind((i) => MarkerController()),
    Bind((i) => MarkingController()),
    Bind((i) => PostitDao()),
    Bind((i) => UserDao()),
    Bind((i) => MarkerDao()),
    Bind((i) => MarkingDao()),
    Bind((i) => User()),
    Bind((i) => UserSettings()),
    Bind((i) => LoginController()),
  ];

  @override
  // Root Widget
  Widget get bootstrap => AppWidget();

  @override
  // Modulos associados a este aplicativo
  List<ModularRouter> get routers => [
    ModularRouter(SplashPage.routeName, module: SplashModule()),
    ModularRouter(LoginPage.routeName, module: LoginModule()),
    ModularRouter(HomePage.routeName, module: HomeModule()),
  ];

}