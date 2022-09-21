import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:volunteer/Admin/Home_Admin.dart';
import 'package:volunteer/Database/Auth.dart';
import 'package:volunteer/Navigator/NaviOwner.dart';
import 'package:volunteer/Owner/Home_Owner.dart';
import 'package:volunteer/Users/Home_User.dart';
import 'package:volunteer/Navigator/NaviUser.dart';
import 'package:volunteer/componance/Font.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  var email;
  var pass;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            backgroundColor: const Color.fromARGB(226, 140, 57, 248),
            body: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 90.0),
                      Text("Login", style: Roboto_18_Black_B),
                      const SizedBox(height: 60.0),
                      //Todo Email
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black)),
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            hintText: "Email",
                            filled: true,
                            prefixIcon:
                                const Icon(Icons.mail, color: Colors.black),
                            contentPadding: const EdgeInsets.all(15.0),
                          ),
                          onSaved: (value) {
                            email = value;
                          },
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      //Todo Password
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            border: const OutlineInputBorder(),
                            hintText: "Password",
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: Icon(Icons.lock, color: Colors.black),
                            contentPadding: EdgeInsets.all(15.0),
                          ),
                          obscureText: true,
                          onSaved: (value) {
                            pass = value;
                          },
                        ),
                      ),

                      const SizedBox(height: 60.0),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(100, 0, 100, 0),
                        child: Container(
                          width: double.infinity,
                          child: RawMaterialButton(
                            fillColor: Colors.black,
                            elevation: 0.0,
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            onPressed: () async {
                              _formKey.currentState?.save();
                              if (email == null && pass == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('กรุณากรอกข้อมูลให้ครบ')));
                              } else {
                                _auth.Login(email, pass, context);
                              }
                              // Navigator.of(context).pushReplacement(
                              //     MaterialPageRoute(
                              //         builder: (context) => NavibarUser()));
                              //print("Emil = $email");
                              //print("Pass = $pass");
                            },
                            child: const Text("เข้าสู่ระบบ",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }
}
