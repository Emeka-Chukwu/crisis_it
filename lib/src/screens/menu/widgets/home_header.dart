import 'package:create_it/src/cores/colors.dart';
import 'package:create_it/src/cores/cores.dart';
import 'package:create_it/src/services/user_services.dart';
import 'package:create_it/src/view_model/user.dart';
import 'package:create_it/src/view_model/user_riverpod_initialization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: null,
          child: Icon(
            Icons.location_on_outlined,
            color: AppColor.blue,
          ),
        ),
        XMargin(5),

        Consumer(builder: (context, watch, child) {
          final user = watch(userProvider);
          // user.getUserLocation();
          return Expanded(child: Text("${user.place}"));
        }),
        // GestureDetector(
        //   onTap: null,
        //   child: Icon(
        //     Icons.notifications_none,
        //     color: AppColor.bBlue,
        //   ),
        // )
      ],
    );
  }
}

class HomeHeaderSecond extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final user = watch(userProvider);

        if (user.place == "") {
          user.getUserLocation();
        }
        print("name here ${user.email}");
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text("Hi,",
                    style: TextStyle(
                      color: AppColor.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    )),
                XMargin(5),
                Text("${user.email}!",
                    style: TextStyle(
                      color: AppColor.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    )),
              ],
            ),
            // GestureDetector(
            //     onTap: null,
            //     child: Container(
            //       width: 35,
            //       height: 35,
            //       decoration: BoxDecoration(
            //         color: AppColor.greyBlue,
            //         shape: BoxShape.circle,
            //       ),
            //       child: Icon(
            //         Icons.notifications_none,
            //         color: AppColor.bBlue,
            //       ),
            //     ))
          ],
        );
      },
    );
  }
}

class HomeHeaderThird extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Videos",
            style: TextStyle(
              color: AppColor.darkBlue,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            )),
        GestureDetector(
            onTap: null,
            child: Text("See all",
                style: TextStyle(
                  color: AppColor.darkBlue,
                ))),
      ],
    );
  }
}

class HomeHeaderFouth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Audios",
            style: TextStyle(
              color: AppColor.darkBlue,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            )),
        GestureDetector(
            onTap: null,
            child: Text("See all",
                style: TextStyle(
                  color: AppColor.bBlue,
                ))),
      ],
    );
  }
}

class HomeHeaderFifth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Photos",
            style: TextStyle(
              color: AppColor.darkBlue,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            )),
        GestureDetector(
            onTap: null,
            child: Text("See all",
                style: TextStyle(
                  color: AppColor.darkBlue,
                ))),
      ],
    );
  }
}
