import 'package:create_it/src/cores/cores.dart';
import 'package:create_it/src/view_model/user.dart';
import 'package:flutter/material.dart';

class AuthsForm extends StatelessWidget {
  final GlobalKey<FormState> formkey;
  final Function onTap;
  final bool isLogin;
  final UserProvider user;
  final TextEditingController emailController;
  final TextEditingController passController;
  TextEditingController? nameController;

  AuthsForm({
    Key? key,
    required this.formkey,
    required this.onTap,
    required this.isLogin,
    required this.user,
    required this.emailController,
    required this.passController,
    this.nameController,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: formkey,
        child: Column(
          children: [
            Text(
              isLogin ? "Login" : "Sign Up",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: AppColor.darkBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (!isLogin) SizedBox(height: 20),
            if (!isLogin)
              TextFormField(
                keyboardType: TextInputType.text,
                validator: (string) => string!.length > 3
                    ? null
                    : "name must be greater than 3 characters",
                onChanged: (str) => str.length > 5 ? null : "error",
                controller: nameController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  hintText: "name",
                  border: OutlineInputBorder(),
                ),
              ),
            SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              validator: (str) => str!.length > 5 ? null : "email not correct",
              onChanged: (str) => str.length > 0 ? null : "error",
              controller: emailController,
              decoration: InputDecoration(
                hintText: "example@email.com",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.text,
              validator: (string) => string!.length > 4
                  ? null
                  : "password must be 6 or more characters",
              onChanged: (str) => str.length > 5 ? null : "error",
              controller: passController,
              decoration: InputDecoration(
                hintText: "password",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () => onTap(),
              child: Container(
                width: double.infinity,
                height: 50,
                color: AppColor.darkBlue,
                child: Center(
                  child: Text(
                    isLogin ? "Login" : "Sign Up",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
