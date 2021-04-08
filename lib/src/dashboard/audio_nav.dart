import 'package:create_it/src/screens/audio/audio_screen.dart';
import 'package:create_it/src/screens/menu/home.dart';
import 'package:flutter/material.dart';

class AudioNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: audioNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            // ignore: missing_return
            builder: (BuildContext context) {
              switch (settings.name) {
                case "/":
                  return AudioUpload();
                default:
                  return AudioUpload();
              }
            });
      },
    );
  }
}

GlobalKey<NavigatorState> audioNavigatorKey = GlobalKey<NavigatorState>();
