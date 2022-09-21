// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:volunteer/Database/Auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  var email;
  var pass;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(226, 140, 57, 248),
            title: const Text("เพิ่มผู้กู้ยืมกยศ.")),
        body: Form(
          key: _formKey,
          child: ListView(
            children: [
              Column(
                children: [
                  const SizedBox(height: 80.0),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
                    child:
                        //Todo Email
                        TextFormField(
                      decoration: const InputDecoration(
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 18),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(226, 140, 57, 248))),
                        labelText: "Email",
                        hintText: "กรอกอีเมล",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (value) {
                        email = value;
                      },
                    ),
                  ),

                  //Todo Password
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelStyle:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(226, 140, 57, 248))),
                        labelText: "Password",
                        hintText: "กรอกรหัสผ่าน",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      onSaved: (value) {
                        pass = value;
                      },
                    ),
                  ),
                  const SizedBox(height: 60.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 10.0),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(225, 4, 0, 9),
                        ),
                        child: const Text("เพิ่ม"),
                        onPressed: () async {
                          _formKey.currentState?.save();
                          if (email == null && pass == null) {
                            const Text("กรุณากรอกข้อมูลให้ครบ");
                          } else {
                            _auth.registerUser(email, pass, context);
                            addSetDoc(
                              context,
                              {
                                "alarm_add": 1,
                                "day": 0,
                                "month": 0,
                                "year": 0,
                              },
                              "SetDoc_Admin",
                            );
                            addSetHour(
                              context,
                              {"hour": "0"},
                              "HourDoc_Admin",
                            );
                            print("เพิ่มผู้ใช้เรียบร้อย");
                          }
                          _formKey.currentState!.reset();

                          //print("Emil = $email");
                          //print("Pass = $pass");
                        },
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ));
  }

  Future<void> addSetDoc(
      BuildContext context, Map<String, dynamic> data, String documentName) {
    return FirebaseFirestore.instance
        .collection("Admin")
        .doc("SetDoc_Admin")
        .update(data);
  }

  Future<void> addSetHour(
      BuildContext context, Map<String, dynamic> data, String documentName) {
    return FirebaseFirestore.instance
        .collection("Admin")
        .doc("SetHour_Admin")
        .set(data);
  }
}
