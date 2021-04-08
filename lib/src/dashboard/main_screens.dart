import 'package:create_it/src/dashboard/bottom_sheet.dart';
import 'package:create_it/src/view_model/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './items.dart';

final dashBoardProvider =
    ChangeNotifierProvider<BottomSheetProvider>((ref) => BottomSheetProvider());

class MainScreenDashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final dashBoard = watch(dashBoardProvider);
      return Scaffold(
        body: buildBody(dashBoard.index),
        bottomNavigationBar: buildBottomNavigationBar(dashBoard, context),
      );
    });
  }
}
