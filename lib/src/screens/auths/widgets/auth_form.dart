import 'package:create_it/src/cores/cores.dart';
import 'package:create_it/src/view_model/user.dart';
import 'package:flutter/material.dart';

import '../forgot_password.dart';

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
            // Text(
            //   isLogin ? "Login" : "Sign Up",
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //     fontSize: 18,
            //     color: AppColor.darkBlue,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
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
                  hintText: "Name",
                  hintStyle: TextStyle(color: AppColor.darkGreenText),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColor.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColor.grey),
                  ),
                ),
              ),
            if (!isLogin)
              DropdownButtonFormField(
                hint: Text("Select your Gender"),
                items: user.genders.map((String gender) {
                  return DropdownMenuItem(
                    value: gender,
                    child:
                        // Icon(Icons.male),
                        Text(
                      gender,
                      style: TextStyle(color: AppColor.darkGreenText),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  user.setGender(newValue.toString());
                  // print(newValue);
                  //  user.setGender()
                  // do other stuff with _category
                  //  setState(() => _category = newValue);
                },
                value: user.gender,
                decoration: InputDecoration(),
              ),
            SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              validator: (str) => str!.length > 5 ? null : "email not correct",
              onChanged: (str) => str.length > 0 ? null : "error",
              controller: emailController,
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
            SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.text,
              obscureText: user.obscureText,
              validator: (string) => string!.length > 5
                  ? null
                  : "password must be 6 or more characters",
              onChanged: (str) => str.length > 5 ? null : "error",
              controller: passController,
              decoration: InputDecoration(
                hintText: "Password",
                hintStyle: TextStyle(color: AppColor.darkGreenText),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColor.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColor.grey),
                ),
                suffixIcon: user.obscureText
                    ? IconButton(
                        icon: Icon(Icons.visibility, color: AppColor.grey),
                        onPressed: () {
                          user.changeObscureText();
                          // print(user)
                        })
                    : IconButton(
                        icon: Icon(
                          Icons.visibility_off,
                          color: AppColor.grey,
                        ),
                        onPressed: () {
                          user.changeObscureText();
                        }),
              ),
            ),
            // SizedBox(height: 20),
            YMargin(Responsive.screenHeight(3, context)),
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () => changeScreen(context, ForgotPassword()),
                child: Text(
                  "Fogot password?",
                  style: TextStyle(
                    color: AppColor.grey,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            YMargin(Responsive.screenHeight(10, context)),
            GestureDetector(
              onTap: () => onTap(),
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColor.darkGreen,
                  borderRadius: BorderRadius.circular(15),
                ),
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
