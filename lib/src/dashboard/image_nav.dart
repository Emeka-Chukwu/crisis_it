import 'package:create_it/src/screens/images/image_screen.dart';
import 'package:create_it/src/screens/menu/home.dart';
import 'package:flutter/material.dart';

class ImageNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: imageNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            // ignore: missing_return
            builder: (BuildContext context) {
              switch (settings.name) {
                case "/":
                  return ImageUpload();
                default:
                  return ImageUpload();
              }
            });
      },
    );
  }
}

GlobalKey<NavigatorState> imageNavigatorKey = GlobalKey<NavigatorState>();
