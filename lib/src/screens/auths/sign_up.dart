import 'package:create_it/src/screens/auths/widgets/widgets.dart';
import 'package:create_it/src/view_model/user_riverpod_initialization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../cores/cores.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer(
          builder: (context, watch, child) {
            final user = watch(userProvider);
            return SafeArea(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    YMargin(Responsive.screenHeight(3, context)),
                    Image(
                      image: AssetImage("logo_main".png),
                      width: Responsive.screenWidth(30, context),
                    ),
                    YMargin(Responsive.screenHeight(10, context)),
                    Row(
                      children: [
                        Text("Sign Up",
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
                      isLogin: false,
                      user: user,
                      emailController: emailController,
                      passController: passController,
                      nameController: nameController,
                      onTap: () {
                        if (formkey.currentState!.validate()) {
                          user.setTheValuesOfTheVaribles(nameController.text,
                              emailController.text, passController.text);
                          user.signUpUsers(context);
                        }
                      },
                    ),
                    YMargin(10),
                    const LoginRegisterText(
                      loginScreen: false,
                    )
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
