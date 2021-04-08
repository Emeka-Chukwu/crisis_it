import 'package:create_it/src/cores/cores.dart';
import 'package:flutter/material.dart';

class AlertDialogClass {
  static void progressBar(BuildContext context,
      {required String title,
      required String description,
      required Color color,
      Color white = Colors.white}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: color,
            content: Container(
              height: Responsive.screenHeight(20, context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  YMargin(
                    Responsive.screenHeight(1, context),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      color: white,
                      fontSize: 12,
                    ),
                  ),
                  YMargin(
                    Responsive.screenHeight(2, context),
                  ),
                  CircularProgressIndicator(
                    strokeWidth: Responsive.screenWidth(1, context),
                    backgroundColor: white,
                  ),
                  YMargin(
                    Responsive.screenHeight(2.5, context),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      color: white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            // actions: [
            //   FlatButton(
            //       onPressed: () => Navigator.of(context).pop(), child: Text("Ok"))
            // ],
          );
        });
  }

  static void dialogWarning(BuildContext context,
      {required String title,
      required String description,
      required Color color,
      Color white = Colors.white}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // backgroundColor: color,
            content: Container(
              height: Responsive.screenHeight(15, context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  YMargin(
                    Responsive.screenHeight(1, context),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      color: color,
                      fontSize: 12,
                    ),
                  ),
                  YMargin(
                    Responsive.screenHeight(1, context),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      color: color,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("Ok"))
            ],
          );
        });
  }

  static void progressBarUpload(BuildContext context,
      {required String title,
      required String description,
      required Color color,
      Color white = Colors.white}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: white,
            content: Container(
              height: Responsive.screenHeight(16, context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  YMargin(
                    Responsive.screenHeight(1, context),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      color: color,
                      fontSize: 12,
                    ),
                  ),
                  YMargin(
                    Responsive.screenHeight(1, context),
                  ),
                  CircularProgressIndicator(
                    strokeWidth: Responsive.screenWidth(1, context),
                    backgroundColor: white,
                  ),
                  YMargin(
                    Responsive.screenHeight(2.5, context),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      color: color,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            // actions: [
            //   FlatButton(
            //       onPressed: () => Navigator.of(context).pop(), child: Text("Ok"))
            // ],
          );
        });
  }
}
