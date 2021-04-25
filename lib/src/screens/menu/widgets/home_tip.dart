import 'package:create_it/src/cores/cores.dart';
import 'package:flutter/material.dart';

class HomeTip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Responsive.screenWidth(3.5, context)),
      width: Responsive.screenWidth(100, context),
      height: 140,
      decoration: BoxDecoration(
        color: AppColor.lightGreen,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        children: [
          Image(
            image: AssetImage("image".png),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Card(
                  color: AppColor.lightGreen,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // color: AppColor.grey,
                    ),
                    child: Center(
                        child: Text(
                      "!",
                      style: TextStyle(
                        color: AppColor.darkGreen,
                      ),
                    )),
                  ),
                ),
              ),
              Text(
                "Tip",
                style: TextStyle(
                  color: AppColor.green,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
              ),
              Text(
                "In case of any urgent emergency, use any of the quick actions to quickly record or make a call",
                style: TextStyle(
                  color: AppColor.darkGreen,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
