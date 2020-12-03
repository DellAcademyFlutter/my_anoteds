import 'package:flutter_modular/flutter_modular.dart';
import 'controller/home_controller.dart';
import 'package:my_anoteds/app/modules/home/data/postit_dao.dart';
import 'package:my_anoteds/app/modules/home/view/crud_postit_page.dart';
import 'package:my_anoteds/app/modules/home/home_page.dart';
import 'package:my_anoteds/app/modules/home/model/postit.dart';
import 'package:my_anoteds/app/modules/home/model/user.dart';

import 'data/users_dao.dart';

class HomeModule extends ChildModule {
  @override
  // TODO: implement binds
  List<Bind> get binds => [
        Bind((i) => HomeController()),
        Bind((i) => User(postits: List<Postit>())),
        Bind((i) => PostitDao()),
        Bind((i) => UserDao()),
      ];

  @override
  // TODO: implement routers
  List<ModularRouter> get routers => [
        ModularRouter(
          HomePage.routeName,
          child: (_, args) => HomePage(),
          transition: TransitionType.leftToRightWithFade,
        ),
        ModularRouter(
          CrudPostitPage.routeName,
          child: (_, args) => CrudPostitPage(
            postit: args.data.postit,
          ),
          transition: TransitionType.fadeIn,
        ),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
