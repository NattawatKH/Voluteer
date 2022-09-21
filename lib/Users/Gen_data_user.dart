import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:volunteer/Admin/AddUser.dart';
import 'package:volunteer/Navigator/NaviUser.dart';
import 'package:volunteer/Users/Home_User.dart';
import 'package:volunteer/Users/List_User.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GenDataUser extends StatefulWidget {
  const GenDataUser(
      {Key? key,
      required this.name,
      required this.email,
      required this.user_go,
      required this.time_add,
      required this.confirm,
      required this.day,
      required this.time_go,
      required this.locacion,
      required this.detail,
      required this.uid})
      : super(key: key);
  final String name;
  final String email;
  final String user_go;
  final time_add;
  final String confirm;
  final String day;
  final String time_go;
  final String locacion;
  final String detail;
  final String uid;

  @override
  State<GenDataUser> createState() => _GenDataUserState();
}

class _GenDataUserState extends State<GenDataUser> {
  User? user = FirebaseAuth.instance.currentUser;

  final name_user = TextEditingController();
  final num_user = TextEditingController();
  final group = TextEditingController();
  final major = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection("User").get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                  backgroundColor: const Color.fromARGB(226, 140, 57, 248),
                  title: const Text('Error')),
              body: Center(child: Text("${snapshot.error}")),
            );
          }
          if (snapshot.hasData) {
            return Scaffold(
                appBar: AppBar(
                  title: const Text("ลงทะเบียน"),
                  backgroundColor: Color.fromARGB(226, 140, 57, 248),
                ),
                body: SafeArea(
                    child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 236, 235, 235),
                      ),
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                              child: Container(
                                color: Colors.black12,
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    20, 10, 20, 0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // ignore: duplicate_ignore
                                      const Padding(
                                          padding: EdgeInsets.all(10)),
                                      TextFormField(
                                        decoration: const InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      226, 140, 57, 248))),
                                          border: OutlineInputBorder(),
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintText: 'ชื่อ',
                                        ),
                                        // ignore: non_constant_identifier_names
                                        controller: name_user,
                                      ),
                                      Padding(padding: const EdgeInsets.all(5)),
                                      TextFormField(
                                        decoration: const InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color.fromARGB(
                                                        226, 140, 57, 248))),
                                            border: OutlineInputBorder(),
                                            filled: true,
                                            fillColor: Colors.white,
                                            hintText: 'รหัสนิสิต,'),
                                        keyboardType: TextInputType.number,
                                        controller: num_user,
                                      ),
                                      Padding(padding: const EdgeInsets.all(5)),
                                      TextFormField(
                                        decoration: const InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      226, 140, 57, 248))),
                                          border: OutlineInputBorder(),
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintText: 'คณะ',
                                        ),
                                        // ignore: non_constant_identifier_names
                                        controller: group,
                                      ),
                                      Padding(padding: const EdgeInsets.all(5)),
                                      TextFormField(
                                        decoration: const InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      226, 140, 57, 248))),
                                          border: OutlineInputBorder(),
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintText: 'สาขาวิชา',
                                        ),
                                        // ignore: non_constant_identifier_names
                                        controller: major,
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.all(10)),
                                      Column(
                                        children: [
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: const Color.fromARGB(
                                                      225, 4, 0, 9),
                                                ),
                                                onPressed: () {
                                                  if (name_user.text == "" ||
                                                      num_user.text == "" ||
                                                      group.text == "" ||
                                                      major.text == "") {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    'กรุณากรอกข้อมูลให้ครบ')));
                                                  } else {
                                                    Adduser_Indata(
                                                        context,
                                                        {
                                                          "name": widget.name,
                                                          "name_owner":
                                                              widget.email,
                                                          "user_go":
                                                              widget.user_go,
                                                          "user_ID": user!.uid,
                                                          "time_add":
                                                              widget.time_add,
                                                          "confirm_user": "1",
                                                          "day": widget.day,
                                                          "time_go":
                                                              widget.time_go,
                                                          "locacion":
                                                              widget.locacion,
                                                          "detail":
                                                              widget.detail,
                                                          "id_owner":
                                                              widget.uid,
                                                          "completed": 0,
                                                        },
                                                        user!.uid);
                                                    AddToUser(
                                                        context,
                                                        {
                                                          "user_name":
                                                              name_user.text,
                                                          "num_user":
                                                              num_user.text,
                                                          "group": group.text,
                                                          "major": major.text,
                                                        },
                                                        user!.uid);

                                                    AddToOwner(
                                                        context,
                                                        {
                                                          "confirm_user": "1",
                                                          "user_name":
                                                              name_user.text,
                                                          "num_user":
                                                              num_user.text,
                                                          "group": group.text,
                                                          "major": major.text,
                                                        },
                                                        widget.uid);

                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    'ลงทะเบียนกิจกรรมแล้ว')));
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                HomeUser()));
                                                    Navigator.of(context)
                                                        .pushReplacement(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        NavibarUser()));
                                                  }
                                                },
                                                child: const Text("บันทึก"),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                )));
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  Future<void> Adduser_Indata(
      BuildContext context, Map<String, dynamic> data, String documentName) {
    return FirebaseFirestore.instance
        .collection("User")
        .doc(user!.uid)
        .collection("Activity")
        .doc(widget.name)
        .set(data)
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> AddToUser(
      BuildContext context, Map<String, dynamic> data, String documentName) {
    return FirebaseFirestore.instance
        .collection("User")
        .doc(user!.uid)
        .update(data)
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> AddToOwner(
      BuildContext context, Map<String, dynamic> data, String documentName) {
    return FirebaseFirestore.instance
        .collection("User")
        .doc("${widget.uid}")
        .collection("Activity")
        .doc()
        .set(data)
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> AddUserInActivity(
      BuildContext context, Map<String, dynamic> data, String documentName) {
    return FirebaseFirestore.instance
        .collection("ActivityDataUser")
        .doc()
        .set(data);
  }
}
