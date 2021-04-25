import 'package:create_it/src/dashboard/video_nav.dart';
import 'package:create_it/src/screens/audio/audio_screen.dart';
import 'package:create_it/src/screens/call/call.dart';
import 'package:create_it/src/screens/menu/home.dart';
import 'package:flutter/material.dart';

Widget buildBody(itemBuild) {
  switch (itemBuild) {
    case 0:
      return MenuHome();
    // break;
    case 1:
      return VideoNavigation();
    // break;
    case 2:
      return DialCallScreen();
    // break;
    case 3:
      return AudioUpload();
    // break;
    case 4:
      return Scaffold();
    // break;
    default:
      return MenuHome();
  }
}
