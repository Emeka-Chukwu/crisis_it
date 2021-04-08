import 'package:create_it/src/cores/cores.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function onTap;
  final double width;

  const SearchBar({
    Key? key,
    required this.controller,
    required this.onTap,
    this.width = 90,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Responsive.screenHeight(7, context),
      width: Responsive.screenWidth(width, context),
      color: AppColor.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 12),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search people and file",
                    hintStyle: TextStyle(color: AppColor.greyBlue)),
              ),
            ),
          ),
          IconButton(
              icon: Icon(
                Icons.search,
                color: AppColor.greyBlue,
              ),
              onPressed: null)
        ],
      ),
    );
  }
}
