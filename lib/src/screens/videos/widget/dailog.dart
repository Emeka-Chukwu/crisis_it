import 'package:create_it/src/cores/cores.dart';
import 'package:create_it/src/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void selectTypeOfUpload(
        BuildContext context, Function onTapImport, Function onTapRecord) =>
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text("Select type of Video"),
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
                  title: "Record",
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
