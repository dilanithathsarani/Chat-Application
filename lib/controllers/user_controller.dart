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
      final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
      final userData = await userCollection.doc(uid).get();

      return UserModel.fromJson(userData.data() as Map<String, dynamic>);
    } catch (e) {
      Logger().e(e);
      return null;
    }
    
  }
}
