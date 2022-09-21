import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:volunteer/Admin/PageHome/Infer.dart';
import 'package:volunteer/Admin/PageHome/List.dart';
import 'package:volunteer/Admin/SetDoc_Admin.dart';
import 'package:volunteer/Admin/SetHour_Admin.dart';
import 'package:volunteer/Database/Auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:volunteer/Login.dart';
import 'package:volunteer/componance/Font.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({Key? key}) : super(key: key);

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  User? user = FirebaseAuth.instance.currentUser;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("User")
                .doc(user!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return DefaultTabController(
                length: 2,
                child: Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: const Color(0xFFA46EE8),
                    title: Text(user!.email.toString()),
                    actions: <Widget>[
                      IconButton(
                          icon: const Icon(Icons.newspaper),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SetDayDocu()));
                          }),
                      IconButton(
                          icon: const Icon(Icons.access_time),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SetHourAdmin()));
                          }),
                      // IconButton(
                      //     icon: const Icon(Icons.logout),
                      //     onPressed: () {
                      //       _auth.signOut().then((value) {
                      //         Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //                 builder: (context) => LoginPage()));
                      //       }).catchError((err) => print("Login error: $err"));
                      //     }),
                      IconButton(
                        onPressed: () {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('ออกจากระบบ'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'ยกเลิก'),
                                  child: const Text('ยกเลิก'),
                                ),
                                TextButton(
                                    child: const Text('ตกลง'),
                                    onPressed: () {
                                      _auth.signOut().then((value) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginPage()));
                                      }).catchError(
                                          (err) => print("Login error: $err"));
                                    }),
                              ],
                            ),
                          );
                        },
                        icon: const Icon(Icons.logout),
                      ),
                    ],
                    bottom: TabBar(
                      indicatorSize: TabBarIndicatorSize.label,
                      indicator: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          color: Colors.white),
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.white,
                      tabs: [
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("สรุป", style: Home_Indur_18),
                          ),
                        ),
                        Tab(
                            child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "รายการคำขอ",
                            style: Home_Allow_head_18,
                          ),
                        ))
                      ],
                    ),
                  ),
                  body: const TabBarView(
                    children: [
                      InferPage(),
                      ListPage(),
                    ],
                  ),
                ),
              );
            }));
  }
}
