//{@Buttom  Navigation}  design for the dashbaord bottom navigation
import 'package:create_it/src/cores/colors.dart';
import 'package:create_it/src/view_model/bottom_sheet.dart';
import 'package:flutter/material.dart';

BottomNavigationBar buildBottomNavigationBar(
    BottomSheetProvider provider, BuildContext context) {
  return BottomNavigationBar(
    selectedItemColor: AppColor.green,
    unselectedItemColor: Colors.grey,
    showUnselectedLabels: true,
    currentIndex: provider.index,
    type: BottomNavigationBarType.fixed,
    onTap: (index) {
      switch (index) {
        case 0:
          provider.changeTheBottomsheet(index);
          break;
        case 1:
          provider.changeTheBottomsheet(index);
          break;
        case 2:
          provider.changeTheBottomsheet(index);
          break;
        case 3:
          provider.changeTheBottomsheet(index);
          break;
        // case 4:
        //   provider.changeTheBottomsheet(index);
        //   break;
        // default:
      }
    },
    items: [
      BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
      BottomNavigationBarItem(
          label: 'History', icon: Icon(Icons.history_edu_sharp)),
      BottomNavigationBarItem(label: 'Info', icon: Icon(Icons.info)),
      BottomNavigationBarItem(
          label: 'Contacts', icon: Icon(Icons.contact_phone)),

      // BottomNavigationBarItem(label: 'Audio', icon: Icon(Icons.audiotrack)),
    ],
  );
}
