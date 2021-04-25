import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String name;
  String email;
  String password;
  String imageUrl;
  String gender;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.imageUrl,
    this.gender = "Male",
  });

  factory UserModel.fromJson(DocumentSnapshot snapshot) => UserModel(
        id: snapshot.id.toString(),
        name: snapshot.data()!["name"],
        gender: snapshot.data()!["gender"] ?? "Male",
        email: snapshot.data()!["email"] ?? null,
        password: snapshot.data()!["password"] ?? null,
        imageUrl: snapshot.data()!["imageUrl"] ??
            "https://media.istockphoto.com/photos/businessman-silhouette-as-avatar-or-default-profile-picture-picture-id476085198",
      );

  Map<String, dynamic> toJson() => {
        "name": this.name,
        "email": this.email,
        "imageUrl": this.imageUrl,
        "password": this.password,
        "gender": this.gender,
      };
}
