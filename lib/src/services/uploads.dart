import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:create_it/src/cores/cores.dart';
import 'package:create_it/src/dashboard/main_screens.dart';
import 'package:create_it/src/model/crisis_it.dart';
import 'package:create_it/src/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'send_mail.dart';

class UploadHelper {
  final FirebaseAuth user = FirebaseAuth.instance;
  final Reference storageReference =
      FirebaseStorage.instance.ref().child("users");
  FirebaseFirestore firestorestance = FirebaseFirestore.instance;

  Future submitCrisisData(String mediaPath, String dirName,
      CrisisItModel crisis, BuildContext context, UserModel userModel,
      [int index = 0]) async {
    int endcharactersIndex = mediaPath.lastIndexOf(".");
    String endCharacters = mediaPath.substring(endcharactersIndex);
    File file = File(mediaPath);
    var timeKey = DateTime.now();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    crisis.lat = position.latitude;
    crisis.long = position.longitude;
    // crisis.mediaType = MediaType.VIDEO;

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    crisis.place =
        "${place.street} ${place.locality} ${place.postalCode} ${place.country}";
    final ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child(dirName)
        .child("vid-${DateTime.now().millisecondsSinceEpoch}$endCharacters");
    // .putFile(file, SettableMetadata(contentType: 'video/mp4'));
    if (index == 0) {
      final uploadTask =
          await ref.putFile(file, SettableMetadata(contentType: 'video/mp4'));
    }
    if (index == 1) {
      final uploadTask =
          await ref.putFile(file, SettableMetadata(contentType: 'image/jpg'));
    }
    String userId = user.currentUser!.uid.toString();
    crisis.imageUrl = (await ref.getDownloadURL()).toString();

    firestorestance
        .collection("crisis")
        .add(crisis.toJson())
        .then((value) => print(value));

    // SendEmailToAdmin.sendTheEmail(crisis, userModel);
    SendEmailToAdmin sendTo = SendEmailToAdmin();
    var value = await sendTo.sendTheEmail(crisis, userModel);
    Navigator.pop(context);
    print(value);
    print("value");
    print(value);
    changeScreenWithRemove(context, MainScreenDashBoard());
  }
}

// Future<Position> _determinePosition() async {
//   bool serviceEnabled;
//   LocationPermission permission;

//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     return Future.error('Location services are disabled.');
//   }

//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     if (permission == LocationPermission.denied) {
//       return Future.error('Location permissions are denied');
//     }
//   }
//   return await Geolocator.getCurrentPosition();
// }
