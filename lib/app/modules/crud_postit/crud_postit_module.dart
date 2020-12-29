import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/modules/crud_postit/select_markers_page.dart';
import 'crud_postit_controller.dart';
import 'crud_postit_page.dart';

class CrudPostitModule extends ChildModule {
  @override
  // TODO: implement binds
  List<Bind> get binds => [
    Bind((i) => CrudPostitController()),
  ];

  @override
  // TODO: implement routers
  List<ModularRouter> get routers => [
    ModularRouter(
      CrudPostitPage.routeName,
      child: (_, args) => CrudPostitPage(
        postit: args.data.postit,
      ),
      transition: TransitionType.rightToLeftWithFade,
    ),
    ModularRouter(
      SelectMarkersPage.routeName,
      child: (_, args) => SelectMarkersPage(
        presenter: args.data.presenter,
      ),
    ),
  ];

  static Inject get to => Inject<CrudPostitModule>.of();
}