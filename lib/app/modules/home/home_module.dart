import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/modules/home/gridview_sample.dart';
import 'package:my_anoteds/app/modules/home/home_controller.dart';
import 'package:my_anoteds/app/modules/home/home_page1.dart';

import 'home_page2.dart';

class HomeModule extends ChildModule {
  @override
  // TODO: implement binds
  List<Bind> get binds => [
    Bind((i) => HomeController()),
  ];

  @override
  // TODO: implement routers
  List<ModularRouter> get routers => [
    ModularRouter(
      '/',
      child: (_, args) => HomePage(),
      transition: TransitionType.leftToRightWithFade,
    ), // pagina inicial deste modulo
    //ModularRouter('/page2', child: (_, args) => HomePage2()), // Sem parametros
    ModularRouter(
      '/page2',
      child: (_, args) => HomePage2(arg1: args.data.arg1),
      transition: TransitionType.rightToLeftWithFade,
    ), // Com parametros
    ModularRouter(
      '/page3',
      child: (_, args) => GridViewSample(),
      transition: TransitionType.fadeIn,
    ),
  ];

  static Inject get to => Inject<HomeModule>.of();
}
