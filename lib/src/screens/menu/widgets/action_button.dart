import 'package:create_it/src/cores/cores.dart';
import 'package:flutter/material.dart';

class HomeActionButton extends StatelessWidget {
  final String title;
  final Function onTap;
  final IconData icon;

  const HomeActionButton({
    Key? key,
    required this.title,
    required this.onTap,
    required this.icon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          GestureDetector(
            onTap: () => onTap(),
            child: Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: AppColor.lightGreen,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Icon(
                icon,
                size: 28,
                color: AppColor.darkGreen,
              ),
            ),
          ),
          YMargin(10),
          Text(
            "$title",
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
