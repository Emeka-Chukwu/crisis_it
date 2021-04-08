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
// import 'package:foodApp/utils/utils.dart';

class UserServices {
  // final StorageReference storageReference =
  //     FirebaseStorage.instance.ref().child("users");
  FirebaseFirestore firestorestance = FirebaseFirestore.instance;
  final FirebaseAuth userAuth = FirebaseAuth.instance;
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

    await firestorestance
        .collection("users")
        .doc(firebaseUser!.uid.toString())
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
    } on PlatformException catch (e) {
      // print(e.message);
      print(e.toString());
      return throw PlatformException(code: e.message!);
    } on FirebaseAuthException catch (e) {
      return throw FirebaseAuthException(message: e.message, code: '788');
    }
    print(firebaseUser!.uid.toString() + "eeeeeeeeee");
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
    return userLocation;
  }
}
