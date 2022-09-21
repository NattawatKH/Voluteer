import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:volunteer/Database/Auth.dart';
import 'package:volunteer/Database/CheckLogin.dart';
import 'package:volunteer/Database/dataOwner.dart';
import 'package:volunteer/Login.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  Stream<User?> get authstateChenges => _auth.idTokenChanges();
  final data = DatabaseOwnerUser.instance;

  Future registerOwner(
      String email, String password, BuildContext context) async {
    await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('เพิ่มOwnerสำเร็จ')));
    }).catchError((err) => print("register error: $err"));

    await data.CreateProfileOwner(email);
  }

  Future registerUser(
      String email, String password, BuildContext context) async {
    await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('เพิ่มUserสำเร็จ')));
    }).catchError((err) => print("register error: $err"));

    await data.CreateProfileUser(email);
  }

  Future Login(String email, String password, BuildContext context) async {
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Check()));
    }).catchError((err) => print("Login error: $err"));
  }

  Future Logout(BuildContext context) async {
    await _auth.signOut().then((value) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }).catchError((err) => print("Login error: $err"));
  }
}

class CreateProfileUser {}
