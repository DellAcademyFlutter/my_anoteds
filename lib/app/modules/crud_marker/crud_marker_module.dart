import 'package:flutter_modular/flutter_modular.dart';
import 'crud_marker_controller.dart';
import 'crud_marker_page.dart';

class CrudMarkerModule extends ChildModule {
  @override
  // TODO: implement binds
  List<Bind> get binds => [
        Bind((i) => CrudMarkerController()),
      ];

  @override
  // TODO: implement routers
  List<ModularRouter> get routers => [
        ModularRouter(
          CrudMarkerPage.routeName,
          child: (_, args) => CrudMarkerPage(),
          transition: TransitionType.leftToRightWithFade,
        ),
      ];

  static Inject get to => Inject<CrudMarkerModule>.of();
}
