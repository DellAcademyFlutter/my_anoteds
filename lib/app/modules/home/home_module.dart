import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/modules/home/home_controller.dart';
import 'package:my_anoteds/app/modules/home/home_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
    Bind((i) => HomeController()),
  ];

  @override
  List<ModularRouter> get routers => [
    ModularRouter('/', child: (_, args)=> HomePage()),
  ];

  static Inject get to => Inject<HomeModule>.of();
}