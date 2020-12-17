import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/modules/home/view/crud_postit_page.dart';
import 'package:my_anoteds/app/modules/login/view/signup_page.dart';
import 'package:my_anoteds/app/modules/splash/splash_controller.dart';
import 'package:my_anoteds/app/modules/splash/splash_page.dart';

class SplashModule extends ChildModule {
  @override
  List<Bind> get binds => [
    Bind((i) => SplashController()),
  ];

  @override
  List<ModularRouter> get routers => [
    ModularRouter(
      SplashPage.routeName,
      child: (_, args) => SplashPage(),
      transition: TransitionType.leftToRightWithFade,
    ),
    ModularRouter(
      CrudPostitPage.routeName,
      child: (_, args) => CrudPostitPage(
        postit: args.data.postit,
      ),
      transition: TransitionType.rightToLeftWithFade,
    ),
    ModularRouter(
      SignUpPage.routeName,
      child: (_, args) => SignUpPage(),
      transition: TransitionType.fadeIn,
    ),
  ];

  static Inject get to => Inject<SplashModule>.of();
}