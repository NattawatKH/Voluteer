import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseOwnerUser {
  static DatabaseOwnerUser instance = DatabaseOwnerUser._();
  DatabaseOwnerUser._();

  Future CreateProfileOwner(String email) async {
    final data = FirebaseFirestore.instance.collection('User');
    User? userNow = FirebaseAuth.instance.currentUser;
    await data
        .doc(userNow!.uid)
        .set({
          'email': email,
          'Role': "Owner",
        })
        .then((value) => print("ceate success"))
        .catchError((err) => print("ceate user erroe: $err"));
  }

  Future CreateProfileUser(String email) async {
    final data = FirebaseFirestore.instance.collection('User');
    User? userNow = FirebaseAuth.instance.currentUser;
    await data
        .doc(userNow!.uid)
        .set({
          'email': email,
          'Role': "User",
        })
        .then((value) => print("ceate success"))
        .catchError((err) => print("ceate user erroe: $err"));
  }
}
