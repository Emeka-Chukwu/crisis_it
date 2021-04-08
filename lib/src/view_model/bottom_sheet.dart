import 'package:flutter/cupertino.dart';

class BottomSheetProvider extends ChangeNotifier {
  int index = 0;

  void changeTheBottomsheet(int value) {
    index = value;
    notifyListeners();
  }
}
