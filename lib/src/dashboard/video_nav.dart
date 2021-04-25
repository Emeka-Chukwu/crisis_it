import 'package:create_it/src/screens/history/history.dart';
import 'package:create_it/src/screens/menu/home.dart';
import 'package:create_it/src/screens/videos/video_screen.dart';
import 'package:flutter/material.dart';

class VideoNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: videoNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            // ignore: missing_return
            builder: (BuildContext context) {
              switch (settings.name) {
                case "/":
                  return History();
                default:
                  return History();
              }
            });
      },
    );
  }
}

GlobalKey<NavigatorState> videoNavigatorKey = GlobalKey<NavigatorState>();
