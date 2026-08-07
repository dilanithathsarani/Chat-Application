import 'package:chat_application/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class UserController {
  final userCollection = FirebaseFirestore.instance.collection('users');

  Future<void> saveUserData(UserModel user) async {
    try {
      await userCollection.doc(user.uid).set(user.toJson());
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<UserModel?> fetchUserData() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) return null;

      final userData = await userCollection.doc(uid).get();
      final data = userData.data();
      if (!userData.exists || data == null) return null;

      return UserModel.fromJson(data);
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  Stream<List<UserModel>> getUserStream() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return const Stream.empty();

    return userCollection
        .where('uid', isNotEqualTo: uid)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((userData) => UserModel.fromJson(userData.data()))
              .toList(),
        );
  }
}
