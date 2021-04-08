import 'package:create_it/src/cores/cores.dart';
import 'package:create_it/src/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void selectTypeOfImageToUpload(
        BuildContext context, Function onTapImport, Function onTapRecord) =>
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text("Select type of Image"),
            content: Row(
              children: [
                ButtonImplSecond(
                  title: "Gallery",
                  width: 28,
                  textColor: AppColor.darkBlue,
                  boxColor: AppColor.white,
                  onTap: () {
                    onTapImport();
                    Navigator.pop(context);
                  },
                ),
                ButtonImplSecond(
                  title: "Capture",
                  width: 28,
                  textColor: AppColor.darkBlue,
                  boxColor: AppColor.white,
                  onTap: () {
                    onTapRecord();
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
      },
    );
