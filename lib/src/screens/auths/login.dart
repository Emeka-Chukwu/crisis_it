import 'package:create_it/src/cores/cores.dart';
import 'package:create_it/src/dashboard/main_screens.dart';
import 'package:create_it/src/screens/auths/widgets/widgets.dart';
import 'package:create_it/src/view_model/user_riverpod_initialization.dart';
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
      body: Consumer(
        builder: (context, watch, child) {
          final user = watch(userProvider);
          return SafeArea(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // YMargin(),
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
          );
        },
      ),
    );
  }
}
