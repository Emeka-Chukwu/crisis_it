import 'package:create_it/src/cores/cores.dart';
import 'package:create_it/src/view_model/user_riverpod_initialization.dart';
import 'package:create_it/src/widgets/progress_bar.dart';
import 'package:create_it/src/widgets/second_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgotPassword extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Responsive.screenWidth(5, context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YMargin(Responsive.screenHeight(7, context)),
            Align(
              alignment: Alignment.center,
              child: Image(
                image: AssetImage("logo_main".png),
                width: Responsive.screenWidth(30, context),
              ),
            ),
            YMargin(Responsive.screenHeight(10, context)),
            Text(
              "Forgot Password",
              style: TextStyle(
                color: AppColor.darkGreen,
                fontSize: 32,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
            YMargin(Responsive.screenHeight(3, context)),
            Text(
              "Submit your email address to get \nyour new password",
              style: TextStyle(
                color: AppColor.grey,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.8,
              ),
            ),
            YMargin(Responsive.screenHeight(7, context)),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              validator: (str) => str!.length > 5 ? null : "email not correct",
              onChanged: (str) => str.length > 0 ? null : "error",
              controller: controller,
              decoration: InputDecoration(
                hintText: "Email Address",
                hintStyle: TextStyle(color: AppColor.darkGreenText),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColor.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColor.grey),
                ),
              ),
            ),
            YMargin(Responsive.screenHeight(10, context)),
            Consumer(
              builder: (context, watch, child) {
                final user = watch(userProvider);
                return ButtonNewImpl(
                  buttonColor: AppColor.darkGreen,
                  onTap: () {
                    if (controller.text.isEmpty) {
                      AlertDialogClass.showToast(
                        context,
                        "Email cannot be empty",
                        Alignment.topCenter,
                      );
                      return;
                    }
                    user.forgotPassword(controller.text, context);
                  },
                  textColor: AppColor.white,
                  title: 'Submit',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
