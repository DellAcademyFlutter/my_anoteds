import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/app_controller.dart';
import 'package:my_anoteds/app/app_widget.dart';
import 'package:my_anoteds/app/modules/home/home_module.dart';
import 'package:my_anoteds/app/repositories/shared/user_settings.dart';

import 'controller/marker_controller.dart';
import 'controller/postit_controller.dart';
import 'controller/user_controller.dart';
import 'data/marker.dao.dart';
import 'data/postit_dao.dart';
import 'data/users_dao.dart';
import 'model/postit.dart';
import 'model/user.dart';
import 'modules/login/login_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
    Bind((i) => AppController()),
    Bind((i) => PostitController()),
    Bind((i) => UserController()),
    Bind((i) => MarkerController()),
    Bind((i) => PostitDao()),
    Bind((i) => UserDao()),
    Bind((i) => MarkerDao()),
    Bind((i) => User(postits: List<Postit>())),
    Bind((i) => UserSettings()),
  ];

  @override
  Widget get bootstrap => AppWidget();

  @override
  List<ModularRouter> get routers => [
    ModularRouter('/', module: LoginModule()),
    ModularRouter('/home', module: HomeModule())
  ];

}