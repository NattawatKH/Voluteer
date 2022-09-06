import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:volunteer/Admin/Home_Admin.dart';
import 'package:volunteer/Navigator/NaviOwner.dart';
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
  //final AuthService _auth = AuthService();
  var email;
  var pass;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(226, 140, 57, 248),
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
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        hintText: "Email",
                        prefixIcon: Icon(Icons.mail, color: Colors.black),
                        contentPadding: EdgeInsets.all(15.0),
                      ),
                      onSaved: (value) {
                        email = value;
                      },
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  //Todo Password
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Password",
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
                    padding: EdgeInsets.fromLTRB(100, 0, 100, 0),
                    child: Container(
                      width: double.infinity,
                      child: RawMaterialButton(
                        fillColor: Colors.black,
                        elevation: 0.0,
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        onPressed: () async {
                          // _formKey.currentState?.save();
                          // if (email == null && pass == null) {
                          //   const Text("ห้ามว่าง");
                          // } else {
                          //   // _auth.Login(email, pass, context);
                          // }
                          // //print("Emil = $email");
                          // //print("Pass = $pass");
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => NavibarUser()));
                        },
                        child: Text("เข้าสู่ระบบ",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0)),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => HomeAdmin()));
                      },
                      child: Text("Admin")),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => NavibarOwner()));
                      },
                      child: Text("Owner")),
                ],
              ),
            ],
          ),
        ));
  }
}
