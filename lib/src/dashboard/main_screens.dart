import 'package:create_it/src/dashboard/bottom_sheet.dart';
import 'package:create_it/src/view_model/bottom_sheet.dart';
import 'package:create_it/src/view_model/user_riverpod_initialization.dart';
import 'package:create_it/src/widgets/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './items.dart';
import 'audio_nav.dart';
import 'image_nav.dart';
import 'menu_navigation.dart';
import 'video_nav.dart';

final dashBoardProvider =
    ChangeNotifierProvider<BottomSheetProvider>((ref) => BottomSheetProvider());

class MainScreenDashBoard extends StatefulWidget {
  @override
  _MainScreenDashBoardState createState() => _MainScreenDashBoardState();
}

class _MainScreenDashBoardState extends State<MainScreenDashBoard> {
  List<GlobalKey<NavigatorState>> _navigatorKeys = [
    menuHomeNavigatorKey,
    videoNavigatorKey,
    imageNavigatorKey,
    audioNavigatorKey,
  ];

  Future<bool> _systemBackButtonPressed(int index) {
    if (_navigatorKeys[index].currentState!.canPop()) {
      print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
      _navigatorKeys[index]
          .currentState!
          .pop(_navigatorKeys[index].currentContext);
    } else {
      // SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
      // AlertDialogClass.newDialogLoading(context,
      //     title: "title", description: "description");
      print("hhhhhjjjjjjjjjjjjjjjjjjjjjhhhhhhhhhhhhhhhhh");
      Navigator.pop(context);
    }
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final dashBoard = watch(dashBoardProvider);
      final audio = watch(audioProvider);
      return Scaffold(
        body: WillPopScope(
            onWillPop: () {
              if (audio.isPlaying) {
                audio.stopTheAudioRemote();
              }
              return _systemBackButtonPressed(dashBoard.index);
            },
            child: buildBody(dashBoard.index)),
        bottomNavigationBar: buildBottomNavigationBar(dashBoard, context),
      );
    });
  }
}
