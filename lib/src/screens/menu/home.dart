import 'package:create_it/src/cores/cores.dart';
import 'package:create_it/src/screens/menu/widgets/widgets.dart';
import 'package:create_it/src/view_model/user_riverpod_initialization.dart';
import 'package:create_it/src/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MenuHome extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    context.read(crisisProvider).getAllProducts();

    return Scaffold(
      // backgroundColor: AppColor.grey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.screenWidth(5, context),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                YMargin(20),
                HomeHeader(),
                YMargin(20),
                // align(),
                HomeHeaderSecond(),
                YMargin(20),
                SearchBar(
                  width: 95,
                  onTap: () => null,
                  controller: controller,
                ),
                YMargin(20),
                HomeHeaderThird(),
                YMargin(10),
                HomeFilesWrap(),
                // HomeRecommendation(),
                YMargin(30),
                // HomeHeaderFouth(),
                // YMargin(15),
                // HomeRecommendation(),
                // YMargin(25),
                // HomeHeaderFifth(),
                // YMargin(15),
                // HomeRecommendation(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
