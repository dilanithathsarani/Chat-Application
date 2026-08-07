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
      image: json['image'] as String? ?? '',
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      uid: json['uid'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'image': image, 'name': name, 'email': email, 'uid': uid};
  }
}
