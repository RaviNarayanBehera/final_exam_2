import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../modal/user_model.dart';
import 'auth_service.dart';

class CloudFireStoreService {
  CloudFireStoreService._();

  static CloudFireStoreService cloudFireStoreService =
  CloudFireStoreService._();

  FirebaseFirestore firestore = FirebaseFirestore.instance;


  Future<void> insertUserIntoFireStore(UserModel user) async {
    await firestore.collection("users").doc(user.email).set({
      'name': user.name,
      'email': user.email,
    });
  }

  // Read data for current user - profile
  Future<DocumentSnapshot<Map<String, dynamic>>>
  readCurrentUserFromFireStore() async {
    User? user = AuthServices.authService.getCurrentUser();
    return await firestore.collection("users").doc(user!.email).get();
  }

  // Read all user from fire Store
  Future<QuerySnapshot<Map<String, dynamic>>>
  readAllUserFromCloudFireStore() async {
    User? user = AuthServices.authService.getCurrentUser();
    return await firestore
        .collection('users')
        .where("email", isNotEqualTo: user!.email)
        .get();
  }


}
