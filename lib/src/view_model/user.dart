import 'package:create_it/src/dashboard/main_screens.dart';
import 'package:create_it/src/model/user.dart';
import 'package:create_it/src/screens/auths/guest.dart';
import 'package:create_it/src/services/user_services.dart';
import 'package:create_it/src/cores/change_screen.dart';
import 'package:create_it/src/cores/colors.dart';
import 'package:create_it/src/screens/auths/login.dart';
import 'package:create_it/src/widgets/progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class UserProvider extends ChangeNotifier {
  UserServices userServices = UserServices();
  String name = "";
  String email = "";
  String password = "";
  String place = "";
  bool restoreLogin = true;
  bool obscureText = true;
  String gender = "Male";
  bool showConfirmEmail = false;
  bool showMessage = false;

  void setShowMeassage() {
    showMessage = !showMessage;
    notifyListeners();
  }

  Future<void> sendSMSToAdmin(TextEditingController message,
      List<String> recipents, BuildContext context) async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    double lat = position.latitude;
    double long = position.longitude;
    // crisis.mediaType = MediaType.VIDEO;

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    String placeTOSend =
        "${place.street} ${place.locality} ${place.postalCode} ${place.country}";
    String _result = await sendSMS(
            message:
                "${message.text} \n\n $placeTOSend   \nlat:$lat long:$long",
            recipients: recipents)
        .catchError((onError) {
      print(onError);
      AlertDialogClass.showToast(
        context,
        onError.toString(),
        Alignment.topCenter,
      );
    });

    message.text = "";
  }

  void setShowConfirmEmail() {
    showConfirmEmail = !showConfirmEmail;
    notifyListeners();
  }

  void setGender(String gen) {
    gender = gen;
    notifyListeners();
  }

  void changeObscureText() {
    obscureText = !obscureText;
    notifyListeners();
  }

  List<String> genders = ["Male", "Female"];

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
    AlertDialogClass.newDialogLoading(
      context,
      title: "Loading...",
      description: "Getting your account ready",
    );
    UserModel user = UserModel(
        id: "1",
        name: name,
        email: email,
        password: password,
        imageUrl:
            "https://media.istockphoto.com/photos/businessman-silhouette-as-avatar-or-default-profile-picture-picture-id476085198");

    try {
      final sendMail = await userServices.createUserAccount(user);

      Navigator.pop(context);
      setShowConfirmEmail();
      AlertDialogClass.showToast(
        context,
        "Registered, confirm your email",
        Alignment.topCenter,
      );

      changeScreen(context, LoginScreen());
    } catch (err) {
      print(err.toString());
      Navigator.pop(context);
      AlertDialogClass.showToast(
        context,
        "Password entered does not meet requirement",
        Alignment.topCenter,
      );
      // AlertDialogClass.dialogWarning(context,
      //     title: "Message",
      //     description: "${err.toString()}",
      //     color: AppColor.errorRed);
    }
  }

  void loginUser(BuildContext context) async {
    AlertDialogClass.newDialogLoading(
      context,
      title: "Authenticating...",
      description: "Please wait ",
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
      AlertDialogClass.showToast(
        context,
        err.toString(),
        Alignment.topCenter,
      );
    }
    notifyListeners();
  }

  void logoutUser(BuildContext context) {
    userServices.logoutUserAccount();
    changeScreenWithRemove(context, LoginScreen());
  }

  void userLoginState(BuildContext context) async {
    if (userServices.currentUserExist()) {
      // print("herererrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
      // print(
      // "kkkkkkkkkkkkkkkkkkkkkkkeeeeeeeeeeeeeeeeeeeeeeeeejjjjjjjjjjjjjjjjjjjj");
      try {
        userModel = await userServices.currentUser();
        print(userModel.email);
        print(userModel.name);
        // change to home screen
        changeScreenRemove(context, MainScreenDashBoard());
      } catch (e) {
        // changeScreen(context, LoginScreen());
        changeScreen(context, WelcomeGuest());
      }
    } else {
// change to login
      // changeScreen(context, LoginScreen());
      changeScreen(context, WelcomeGuest());
    }
    restoreLogin = false;
    notifyListeners();
  }

  getUserLocation() async {
    place = await UserServices.getCurrentUserLocation();
    notifyListeners();
  }

  void forgotPassword(String email, BuildContext context) async {
    try {
      await userServices.forgetPaasword(email);
      AlertDialogClass.showToast(
        context,
        "Reset password email has been sent to you",
        Alignment.topCenter,
      );
      changeScreen(context, LoginScreen());
    } catch (err) {
      AlertDialogClass.showToast(
        context,
        err.toString(),
        Alignment.topCenter,
      );
    }
  }
}
