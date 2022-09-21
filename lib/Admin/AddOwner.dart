// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:volunteer/Database/Auth.dart';
import 'package:volunteer/componance/Font.dart';

class AddOwner extends StatefulWidget {
  const AddOwner({Key? key}) : super(key: key);

  @override
  State<AddOwner> createState() => _AddOwnerState();
}

class _AddOwnerState extends State<AddOwner> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  var email;
  var pass;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(226, 140, 57, 248),
            title: const Text("เพิ่มเจ้าของกิจกรรม")),
        body: Form(
          key: _formKey,
          child: ListView(
            children: [
              Column(
                children: [
                  const SizedBox(height: 80.0),

                  //Todo Email
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 18),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(226, 140, 57, 248))),
                        labelText: "Email",
                        hintText: "กรอกอีเมล",
                        border: const OutlineInputBorder(),
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
                            _auth.registerOwner(email, pass, context);
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
}
