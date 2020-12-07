import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/repositories/shared/themes/AppThemes.dart';
import 'package:my_anoteds/app/repositories/shared/user_settings.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserSettings>(
      builder: (context, value) {
        return MaterialApp(
          title: "My Anoteds",
          theme: ThemeCollection.getAppTheme(),
          darkTheme: ThemeCollection.darkTheme(),
          initialRoute: '/',
          navigatorKey: Modular.navigatorKey,
          onGenerateRoute: Modular.generateRoute,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
