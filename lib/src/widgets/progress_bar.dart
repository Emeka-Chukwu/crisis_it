import 'package:create_it/src/cores/cores.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  static void newDialogLoading(
    BuildContext context, {
    required String title,
    required String description,
  }) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // backgroundColor: color,
            content: Container(
              height: Responsive.screenHeight(30, context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // YMargin(
                  //   Responsive.screenHeight(1, context),
                  // ),
                  SvgPicture.asset(
                    "assets/images/megaphone.svg",
                    height: Responsive.screenHeight(6, context),
                    width: Responsive.screenWidth(90, context),
                    fit: BoxFit.contain,
                  ),
                  YMargin(
                    Responsive.screenHeight(1, context),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      color: AppColor.darkGreen,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      height: 1.6,
                    ),
                  ),
                  YMargin(
                    Responsive.screenHeight(2, context),
                  ),
                  CircularProgressIndicator(
                    backgroundColor: AppColor.green,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppColor.darkGreen),
                  ),

                  YMargin(
                    Responsive.screenHeight(1, context),
                  ),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColor.darkGreen,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.6,
                    ),
                  ),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     GestureDetector(
                  //         onTap: () => Navigator.of(context).pop(),
                  //         child: Text(
                  //           "Ok",
                  //           style: TextStyle(
                  //             color: AppColor.darkGreen,
                  //           ),
                  //         ))
                  //   ],
                  // )
                ],
              ),
            ),
          );
        });
  }

  static void newDialogLogout(
    BuildContext context, {
    required Function onTap,
  }) {
    showDialog(
        // barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // backgroundColor: color,
            content: Container(
              height: Responsive.screenHeight(12, context),
              width: Responsive.screenWidth(100, context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // YMargin(
                  //   Responsive.screenHeight(1, context),
                  // ),

                  Text(
                    "Are you sure you want to logout",
                    // textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: AppColor.darkGreen,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      height: 1,
                    ),
                  ),
                  YMargin(
                    Responsive.screenHeight(0, context),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => onTap(),
                        child: Text(
                          "Logout",
                          style: TextStyle(
                            color: Color(0xff7f8e9d),
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      XMargin(20),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: AppColor.green,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  static void showToast(BuildContext context, String text, Alignment align) {
    showFlash(
      context: context,
      duration: const Duration(seconds: 4),
      builder: (context, controller) {
        return Flash.dialog(
          controller: controller,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          backgroundGradient: LinearGradient(
            colors: [Color(0xff00A99D), Color(0xff00A99D)],
          ),
          alignment: align,
          margin: const EdgeInsets.only(bottom: 48),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Responsive.screenWidth(5, context),
                vertical: Responsive.screenWidth(3, context)),
            child: Text(
              text,
              style: TextStyle(
                color: AppColor.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        );
      },
    );
  }
}
