import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/modules/user_settings/user_settings_controller.dart';
import 'package:my_anoteds/app/modules/user_settings/user_settings_page.dart';

class UserSettingsModule extends ChildModule {
  @override
  // TODO: implement binds
  List<Bind> get binds => [
    Bind((i) => UserSettingsController()),
  ];

  @override
  // TODO: implement routers
  List<ModularRouter> get routers => [
    ModularRouter(
      UserSettingsPage.routeName,
      child: (_, args) => UserSettingsPage(),
    ),
  ];

  static Inject get to => Inject<UserSettingsModule>.of();
}
