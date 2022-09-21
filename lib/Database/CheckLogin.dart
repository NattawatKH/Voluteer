import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:volunteer/Admin/Home_Admin.dart';
import 'package:volunteer/serviec/TestCheckWallet.dart';
import 'package:volunteer/Login.dart';
import 'package:volunteer/Navigator/NaviOwner.dart';
import 'package:volunteer/Navigator/NaviUser.dart';
import 'package:volunteer/Owner/Home_Owner.dart';
import 'package:volunteer/Users/Home_User.dart';

class Check extends StatefulWidget {
  const Check({Key? key}) : super(key: key);

  @override
  State<Check> createState() => _CheckState();
}

class _CheckState extends State<Check> {
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> getUserRole(Userid) async {
    await FirebaseFirestore.instance
        .collection('User')
        .doc(Userid)
        .get()
        .then((vale) {
      if (vale.data()!['Role'] == "Admin") {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeAdmin()));
      } else if (vale.data()!['Role'] == "Owner") {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeOwner()));
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => NavibarOwner()));
      } else if (vale.data()!['Role'] == "User") {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeUser()));
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => NavibarUser()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    });
  }

  Future checkLogin() async {
    await Future.delayed(Duration(seconds: 1), () {
      getUserRole(user?.uid);
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
    print("user = ${user?.uid}");
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
