import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:create_it/src/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:foodApp/utils/utils.dart';

class UserServices {
  // final StorageReference storageReference =
  //     FirebaseStorage.instance.ref().child("users");
  FirebaseFirestore firestorestance = FirebaseFirestore.instance;
  final FirebaseAuth userAuth = FirebaseAuth.instance;
  // User? firebaseUser;
  // final Reference storageReference =
  //     FirebaseStorage.instance.ref().child("users");

  User? user;

  bool currentUserExist() {
    return FirebaseAuth.instance.currentUser != null;
  }

  Future currentUser() async {
    user = FirebaseAuth.instance.currentUser;
    print(user!.email);
    print("herererre");
    if (!user!.emailVerified) {
      var actionCodeSettings = ActionCodeSettings(
          url: 'https://www.example.com/?email=${user!.email}',
          dynamicLinkDomain: "example.page.link",
          androidInstallApp: true,
          androidPackageName: "io.devcareer.create_it",
          androidMinimumVersion: "12",
          // android: {
          //   "packageName": "com.example.android",
          //   "installApp": true,
          //   "minimumVersion": "12"
          // },
          iOSBundleId: "com.example.ios",
          handleCodeInApp: true);

      await user!.sendEmailVerification(actionCodeSettings);
      FirebaseAuth auth = FirebaseAuth.instance;

//Get actionCode from the dynamicLink
      final PendingDynamicLinkData data =
          (await FirebaseDynamicLinks.instance.getInitialLink())!;
      final Uri deepLink = data.link;
      var actionCode = deepLink.queryParameters['oobCode'];

      try {
        await auth.checkActionCode(actionCode!);
        await auth.applyActionCode(actionCode);

        // If successful, reload the user:
        auth.currentUser!.reload();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-action-code') {
          print('The code is invalid.');
        }
      }
      // await user!.sendEmailVerification();
      throw ("please verify your email to continue");
    }
    // print(user.uid.toString());
    final usersdoc = await firestorestance
        .collection("users")
        .doc(user!.uid.toString())
        .get()
        .then((value) => value);
    print(usersdoc.exists);
    print(usersdoc);
    if (usersdoc.exists) {
      print("gooto hette");

      return UserModel.fromJson(usersdoc);
    }
  }

  Future<void> createUserAccount(UserModel user) async {
    User? firebaseUser = (await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: user.email, password: user.password))
        .user;

    try {
      await firebaseUser!.sendEmailVerification();
    } catch (e) {
      throw (e.toString());
    }
    await firestorestance
        .collection("users")
        .doc(firebaseUser.uid.toString())
        .set(user.toJson())
        .then((value) {
      print("jjj");
    });

    // return null;
  }
  // user login application logic

  Future<UserModel> loginUserAccount(String email, String password) async {
    // var errorMessage;
    User? firebaseUser;
    try {
      firebaseUser = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password))
          .user;
      if (!firebaseUser!.emailVerified) {
        //disable automatic sending of email verification link
        // firebaseUser.sendEmailVerification();
        throw ("Please verify your email");
      }
    } on PlatformException catch (e) {
      // print(e.message);
      print(e.toString());
      return throw PlatformException(code: e.message!);
    } on FirebaseAuthException catch (e) {
      return throw FirebaseAuthException(message: e.message, code: '788');
    } catch (e) {
      throw (e);
    }
    // print(firebaseUser!.uid.toString() + "eeeeeeeeee");
    DocumentSnapshot docs = await firestorestance
        .collection("users")
        .doc(firebaseUser.uid.toString())
        .get()
        .then((DocumentSnapshot value) {
      print(value.data());
      // return Users.fromSnapshot(value);
      return value;
    });
    // if (docs.exists) {
    return UserModel.fromJson(docs);
    // }
    // }
    // }
    // return null;
  }

  Future logoutUserAccount() async {
    FirebaseAuth user = FirebaseAuth.instance;
    user.signOut();
  }

  Future forgetPaasword(String email) async {
    FirebaseAuth user = FirebaseAuth.instance;
    try {
      user.sendPasswordResetEmail(email: email);
    } catch (err) {
      throw (err);
    }
  }

  Future submitDashBoardImage(File file) async {
    var timeKey = DateTime.now();

    // final StorageUploadTask uploadTask =
    //     storageReference.child(timeKey.toString() + ".jpg").putFile(file);
    // var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    //

    //llllllllllll
//     firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
//     .ref('images/defaultProfile.png');
// // or
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('images')
        .child('defaultProfile.png');

    String userId = userAuth.currentUser!.uid.toString();
    print(userId);
    var data = await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .get()
        .then((value) => value);

    UserModel user = UserModel.fromJson(data);

    // user.imageUrl = imageUrl.toString();
    firestorestance
        .collection("users")
        .doc(userId)
        .set(user.toJson())
        .then((value) => print("nooo"));
  }

  static getCurrentUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // crisis.mediaType = MediaType.VIDEO;

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    String userLocation = "${place.locality}, ${place.country}";
    String userLocationTwo =
        "${place.street} ${place.locality} ${place.postalCode} ${place.country}";
    return [userLocation, userLocationTwo];
  }

  Future handleDynamicLinksSplash() async {
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    // _handleDeepLink(data);
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
      // _handleDeepLink(dynamicLink);
    }, onError: (OnLinkErrorException e) async {
      print('Link Failed: ${e.message}');
    });
  }
}
