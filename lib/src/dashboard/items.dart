import 'package:create_it/src/dashboard/menu_navigation.dart';
import 'package:create_it/src/screens/audio/audio_screen.dart';
import 'package:create_it/src/screens/images/image_screen.dart';
import 'package:create_it/src/screens/menu/home.dart';
import 'package:create_it/src/screens/videos/video_screen.dart';
import 'package:flutter/material.dart';

Widget buildBody(itemBuild) {
  switch (itemBuild) {
    case 0:
      return MenuHomeNavigation();
    // break;
    case 1:
      return VideoUpload();
    // break;
    case 2:
      return ImageUpload();
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
