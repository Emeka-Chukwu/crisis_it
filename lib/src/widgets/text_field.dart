import 'package:create_it/src/cores/cores.dart';
import 'package:flutter/material.dart';

class FieldText extends StatelessWidget {
  final TextEditingController controller;
  final double width;
  final Color color;

  const FieldText({
    Key? key,
    required this.controller,
    this.width = 90,
    this.color = Colors.white,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.screenWidth(width, context),
      color: AppColor.white,
      child: Padding(
        padding: EdgeInsets.only(left: 12),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "textFiled",
              hintStyle: TextStyle(color: AppColor.greyBlue)),
        ),
      ),
    );
  }
}

class FieldTextWithBorder extends StatelessWidget {
  final TextEditingController controller;
  final double width;
  final Color color;

  const FieldTextWithBorder({
    Key? key,
    required this.controller,
    this.width = 90,
    this.color = Colors.white,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.screenWidth(width, context),
      color: AppColor.white,
      child: Padding(
        padding: EdgeInsets.only(left: 0),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColor.bBlue,
                ),
              ),
              border: OutlineInputBorder(),
              hintText: "Title",
              hintStyle: TextStyle(color: AppColor.greyBlue)),
        ),
      ),
    );
  }
}
