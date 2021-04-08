import 'package:create_it/src/screens/menu/home.dart';
import 'package:flutter/material.dart';

class MenuHomeNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: menuHomeNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            // ignore: missing_return
            builder: (BuildContext context) {
              switch (settings.name) {
                case "/":
                  return MenuHome();
                default:
                  return MenuHome();
              }
            });
      },
    );
  }
}

GlobalKey<NavigatorState> menuHomeNavigatorKey = GlobalKey<NavigatorState>();
