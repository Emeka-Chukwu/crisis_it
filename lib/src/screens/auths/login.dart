import 'package:create_it/src/cores/cores.dart';
import 'package:create_it/src/dashboard/main_screens.dart';
import 'package:create_it/src/screens/auths/widgets/widgets.dart';
import 'package:create_it/src/view_model/user_riverpod_initialization.dart';
import 'package:create_it/src/widgets/progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer(
          builder: (context, watch, child) {
            final user = watch(userProvider);
            // AlertDialogClass.showToast(context,
            //     "Confirmation email was sent to you", Alignment.topCenter);
            return SafeArea(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    YMargin(Responsive.screenHeight(3, context)),
                    Image(
                      image: AssetImage("logo_main".png),
                      width: Responsive.screenWidth(30, context),
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // YMargin(),
                          YMargin(Responsive.screenHeight(10, context)),
                          Text(
                            "Welcome ",
                            style: TextStyle(
                              color: AppColor.darkGreen,
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                              height: 1.5,
                            ),
                          ),
                          Row(
                            children: [
                              Text("back",
                                  style: TextStyle(
                                    color: AppColor.darkGreen,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w500,
                                    height: 1.5,
                                  )),
                              Text("!",
                                  style: TextStyle(
                                    color: AppColor.green,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w500,
                                    height: 1.5,
                                  ))
                            ],
                          ),
                          AuthsForm(
                            formkey: formkey,
                            isLogin: true,
                            user: user,
                            emailController: emailController,
                            passController: passController,
                            onTap: () {
                              if (formkey.currentState!.validate()) {
                                user.setTheValuesOfTheVariblesForLogin(
                                    emailController.text, passController.text);
                                user.loginUser(context);
                              }
                            },
                          ),
                          YMargin(10),
                          const LoginRegisterText(
                            loginScreen: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
