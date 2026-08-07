import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String image;
  String name;
  String email;
  String uid;
  bool isOnline;
  DateTime lastSeen;

  UserModel({
    required this.image,
    required this.name,
    required this.email,
    required this.uid,
    required this.isOnline,
    required this.lastSeen,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      image: json['image'] as String? ?? '',
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      uid: json['uid'] as String? ?? '',
      isOnline: json['isOnline'] as bool? ?? false,
      lastSeen: json['lastSeen'] != null ? (json['lastSeen'] as Timestamp).toDate() : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'name': name,
      'email': email,
      'uid': uid,
      'isOnline': isOnline,
      'lastSeen': lastSeen,
    };
  }
}
