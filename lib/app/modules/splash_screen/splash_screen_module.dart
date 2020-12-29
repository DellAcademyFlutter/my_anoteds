import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/modules/home/reminder_page.dart';
import 'package:my_anoteds/app/modules/splash_screen/splash_screen_controller.dart';
import 'package:my_anoteds/app/modules/splash_screen/splash_screen_page.dart';

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
          ReminderPage.routeName,
          child: (_, args) => ReminderPage(
            postit: args.data.postit,
          ),
        ),
      ];

  static Inject get to => Inject<SplashModule>.of();
}
