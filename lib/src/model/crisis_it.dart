import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:create_it/src/cores/cores.dart';
import 'package:create_it/src/screens/history/video_player.dart';
import 'package:create_it/src/view_model/user_riverpod_initialization.dart';
import 'package:create_it/src/view_model/video.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CrisisItModel {
  String id;
  String name;
  String title;
  double lat;
  double long;
  String userId;
  String place;
  String imageUrl;
  String details;
  String incidentType;
  MediaType mediaType;
  String type;
  int time;

  CrisisItModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.title,
    required this.lat,
    required this.long,
    required this.place,
    required this.userId,
    required this.mediaType,
    this.type = "MediaType.IMAGE",
    required this.time,
    required this.incidentType,
    required this.details,
  });

  factory CrisisItModel.fromJson(DocumentSnapshot snapshot) => CrisisItModel(
        id: snapshot.id.toString(),
        name: snapshot.data()!["name"] ?? null,
        imageUrl: snapshot.data()!["imageUrl"] ??
            "https://media.istockphoto.com/photos/businessman-silhouette-as-avatar-or-default-profile-picture-picture-id476085198",
        title: snapshot.data()!["title"],
        lat: snapshot.data()!["lat"],
        long: snapshot.data()!["long"],
        place: snapshot.data()!["place"],
        details: snapshot.data()!["details"] ?? "Nothing",
        userId: snapshot.data()!["userId"],
        type: snapshot.data()!["mediaType"],
        mediaType: getType(snapshot.data()!["mediaType"]),
        time: snapshot.data()!["time"],
        incidentType: snapshot.data()!["incidentType"] ?? "Nothing",
      );

  Map<String, dynamic> toJson() => {
        "name": this.name,
        "imageUrl": this.imageUrl,
        "title": this.title,
        "lat": this.lat,
        "long": this.long,
        "place": this.place,
        "mediaType": this.mediaType.toString(),
        "userId": this.userId,
        "time": this.time,
        "details": this.details,
        "incidentType": this.incidentType,
      };
}

enum MediaType { VIDEO, AUDIO, IMAGE }

MediaType getType(String type) {
  switch (type) {
    case "MediaType.IMAGE":
      return MediaType.IMAGE;
    case "MediaType.AUDIO":
      return MediaType.AUDIO;
    case "MediaType.VIDEO":
      return MediaType.VIDEO;
    default:
      return MediaType.IMAGE;
  }
}

Widget getWidgetTODisplay(
    MediaType type, String path, BuildContext context, VideoProvider video,
    [var crisis]) {
  switch (type) {
    case MediaType.IMAGE:
      return Image(
        image: NetworkImage(path),
        height: Responsive.screenHeight(26, context),
        width: double.infinity,
        fit: BoxFit.cover,
      );
    case MediaType.AUDIO:
      return Container(
        child: Stack(
          children: [
            Image(
              image: AssetImage("assets/images/remote_audio.png"),
              height: Responsive.screenHeight(26, context),
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ],
        ),
      );

    case MediaType.VIDEO:
      return Stack(
        children: [
          VideoPlayer(video.remoteController),
          Center(
            child: GestureDetector(
              onTap: () => changeScreenWithoutRoot(
                  context,
                  VideoPlayerScreen(
                    model: crisis,
                  )),
              child: Icon(
                Icons.play_arrow,
                color: AppColor.darkGreen,
              ),
            ),
          )
        ],
      );
    default:
      return Image(
        image: NetworkImage(path),
        height: Responsive.screenHeight(26, context),
        width: double.infinity,
        fit: BoxFit.cover,
      );
  }
}

Widget getWidgetHistoryToDisplay(
    MediaType type, String path, BuildContext context, VideoProvider video) {
  switch (type) {
    case MediaType.IMAGE:
      return Image(
        image: NetworkImage(path),

        // height: Responsive.screenHeight(10, context),

        width: Responsive.screenWidth(30, context),
        fit: BoxFit.contain,
      );
    case MediaType.AUDIO:
      return Container(
        child: Stack(
          children: [
            Image(
              image: AssetImage("assets/images/remote_audio.png"),
              width: Responsive.screenWidth(30, context),
              fit: BoxFit.cover,
            ),
          ],
        ),
      );

    case MediaType.VIDEO:
      return Container(
          child: VideoPlayer(
            video.remoteController,
          ),
          width: Responsive.screenWidth(30, context));
    default:
      return Image(
        image: NetworkImage(path),
        width: Responsive.screenWidth(30, context),
        fit: BoxFit.cover,
      );
  }
}

Widget getWidgetTypeTODisplay(
    int index, String path, BuildContext context, VideoProvider video) {
  switch (index) {
    case 1:
      return Image.file(
        File(path),
        height: Responsive.screenHeight(28, context),
        width: Responsive.screenWidth(95, context),
        fit: BoxFit.cover,
      );
    case 3:
      return Container(
        child: Stack(
          children: [
            Image(
              image: AssetImage("assets/images/remote_audio.png"),
              height: Responsive.screenHeight(22, context),
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ],
        ),
      );

    case 2:
      return Container(
          height: Responsive.screenHeight(24, context),
          child: VideoPlayer(video.videoController));
    default:
      return Image(
        image: NetworkImage(path),
        height: Responsive.screenHeight(26, context),
        width: double.infinity,
        fit: BoxFit.cover,
      );
  }
}
