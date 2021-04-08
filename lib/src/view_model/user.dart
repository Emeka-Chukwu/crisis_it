import 'package:create_it/src/dashboard/main_screens.dart';
import 'package:create_it/src/model/user.dart';
import 'package:create_it/src/services/user_services.dart';
import 'package:create_it/src/cores/change_screen.dart';
import 'package:create_it/src/cores/colors.dart';
import 'package:create_it/src/screens/auths/login.dart';
import 'package:create_it/src/widgets/progress_bar.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  UserServices userServices = UserServices();
  String name = "";
  String email = "";
  String password = "";
  String place = "";

  UserModel userModel = UserModel(
      id: "",
      name: "name",
      email: "email",
      password: "password",
      imageUrl: "imageUrl");

  void setTheValuesOfTheVaribles(
      String nameOne, String emailOne, String passwordOne) {
    name = nameOne;
    email = emailOne;
    password = passwordOne;
    notifyListeners();
  }

  void setTheValuesOfTheVariblesForLogin(String emailOne, String passwordOne) {
    email = emailOne;
    password = passwordOne;
    notifyListeners();
  }

  void signUpUsers(BuildContext context) async {
    AlertDialogClass.dialogWarning(
      context,
      title: "User Registration",
      description: "Registering",
      color: AppColor.darkBlue,
    );
    UserModel user = UserModel(
        id: "1",
        name: name,
        email: email,
        password: password,
        imageUrl:
            "https://media.istockphoto.com/photos/businessman-silhouette-as-avatar-or-default-profile-picture-picture-id476085198");

    try {
      await userServices.createUserAccount(user);
      Navigator.pop(context);
      changeScreen(context, LoginScreen());
    } catch (err) {
      print(err.toString());
      Navigator.pop(context);
      AlertDialogClass.dialogWarning(context,
          title: "Message",
          description: "${err.toString()}",
          color: AppColor.errorRed);
    }
  }

  void loginUser(BuildContext context) async {
    AlertDialogClass.progressBar(
      context,
      title: "Authentication",
      description: "Loging in",
      color: AppColor.bBlue,
    );

    try {
      userModel = await userServices.loginUserAccount(email, password);
      Navigator.pop(context);
      getUserLocation();
      print(userModel);
      print("userModel");
      changeScreen(context, MainScreenDashBoard());
      // changeScreen(context, LoginScreen());
    } catch (err) {
      print(err.toString());
      Navigator.pop(context);
      AlertDialogClass.dialogWarning(context,
          title: "Message",
          description: "${err.toString()}",
          color: AppColor.errorRed);
    }
    notifyListeners();
  }

  void logoutUser(BuildContext context) {
    userServices.logoutUserAccount();
    // changeScreen(context, widget)
  }

  void userLoginState(BuildContext context) async {
    if (userServices.currentUserExist()) {
      // print("herererrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
      // print(
      // "kkkkkkkkkkkkkkkkkkkkkkkeeeeeeeeeeeeeeeeeeeeeeeeejjjjjjjjjjjjjjjjjjjj");
      userModel = await userServices.currentUser();
      print(userModel.email);
      print(userModel.name);
      // change to home screen
      changeScreen(context, MainScreenDashBoard());
    } else {
// change to login
      changeScreen(context, LoginScreen());
    }
    notifyListeners();
  }

  getUserLocation() async {
    place = await UserServices.getCurrentUserLocation();
    notifyListeners();
  }
}
