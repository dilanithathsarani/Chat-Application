class UserModel {
  String image;
  String name;
  String email;
  String uid;

  UserModel({
    required this.image,
    required this.name,
    required this.email,
    required this.uid,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      image: json['image'],
      name: json['name'],
      email: json['email'],
      uid: json['uid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'name': name,
      'email': email,
      'uid': uid,
    };
  }
}

