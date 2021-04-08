import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:create_it/src/cores/cores.dart';
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
        userId: snapshot.data()!["userId"],
        type: snapshot.data()!["mediaType"],
        mediaType: getType(snapshot.data()!["mediaType"]),
        time: snapshot.data()!["time"],
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
    MediaType type, String path, BuildContext context, VideoProvider video) {
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
      return VideoPlayer(video.remoteController);
    default:
      return Image(
        image: NetworkImage(path),
        height: Responsive.screenHeight(26, context),
        width: double.infinity,
        fit: BoxFit.cover,
      );
  }
}
