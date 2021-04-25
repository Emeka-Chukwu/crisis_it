import 'package:flutter/material.dart';
import '../../cores/cores.dart';
import '../../widgets/second_button.dart';
import 'login.dart';
import 'sign_up.dart';

class WelcomeGuest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: Responsive.screenWidth(5, context),
              vertical: Responsive.screenWidth(5, context)),
          child: Column(
            children: [
              Row(
                children: [
                  Image(
                    image: AssetImage(
                      "logo_main".png,
                    ),
                    width: Responsive.screenWidth(35, context),
                  )
                ],
              ),
              YMargin(Responsive.screenHeight(5, context)),
              Image(
                image: AssetImage(
                  "login_create".png,
                ),
                width: Responsive.screenWidth(90, context),
              ),
              // YMargin(Responsive.screenHeight(5, context)),
              Text(
                "Crisis IT helps you stay safe and take critical actions easily in times of distress",
                style: TextStyle(
                  color: AppColor.darkGreenText,
                  fontSize: 16,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              YMargin(Responsive.screenHeight(8, context)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ButtonNewImpl(
                    buttonColor: AppColor.cyan,
                    onTap: () {
                      changeScreenWithFlash(context, LoginScreen());
                    },
                    textColor: AppColor.darkGreen,
                    title: 'Login',
                    width: 42,
                  ),
                  ButtonNewImpl(
                    buttonColor: AppColor.darkGreen,
                    onTap: () {
                      changeScreen(context, SignUpScreen());
                    },
                    textColor: AppColor.white,
                    title: 'Create Account',
                    width: 42,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
