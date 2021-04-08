import 'package:create_it/src/cores/cores.dart';
import 'package:create_it/src/screens/auths/login.dart';
import 'package:create_it/src/screens/auths/sign_up.dart';
import 'package:flutter/cupertino.dart';

class LoginRegisterText extends StatelessWidget {
  final bool loginScreen;
  const LoginRegisterText({required this.loginScreen});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          loginScreen ? "Don't have an account" : "Already have an account",
          style: TextStyle(
            color: AppColor.black,
          ),
        ),
        XMargin(
          5,
        ),
        GestureDetector(
            onTap: () => changeScreen(
                  context,
                  loginScreen ? SignUpScreen() : LoginScreen(),
                ),
            child: Text(
              loginScreen ? "sign up" : "login",
              style: TextStyle(
                color: AppColor.darkBlue,
                decoration: TextDecoration.underline,
              ),
            ))
      ],
    );
  }
}
