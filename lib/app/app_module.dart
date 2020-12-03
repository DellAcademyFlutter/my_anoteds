import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/app_controller.dart';
import 'package:my_anoteds/app/app_widget.dart';
import 'package:my_anoteds/app/modules/home/home_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
    Bind((i) => AppController())
  ];

  @override
  Widget get bootstrap => AppWidget();

  @override
  List<ModularRouter> get routers => [
    ModularRouter('/', module: HomeModule()),
    ModularRouter('/home', module: HomeModule())
  ];

}