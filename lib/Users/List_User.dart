import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:volunteer/Users/ViewData_User.dart';
import 'package:volunteer/Users/ViewData_User2.dart';

class ListUser extends StatefulWidget {
  const ListUser({
    Key? key,
  }) : super(key: key);

  @override
  State<ListUser> createState() => _ListUserState();
}

class _ListUserState extends State<ListUser> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
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
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Color.fromARGB(226, 140, 57, 248),
                  automaticallyImplyLeading: false,
                  title: Container(
                    child: Text("กิจกรรมที่เข้าร่วม"),
                  ),
                ),
                body: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('User')
                        .doc(user!.uid)
                        .collection("Activity")
                        .where("confirm_user", isEqualTo: "1")
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return SafeArea(
                          child: GestureDetector(
                        onTap: () => FocusScope.of(context).unfocus(),
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 236, 235, 235),
                          ),
                          child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(10, 10, 10, 10),
                                          child: ListView(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            children: [
                                              ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: snapshot
                                                      .data!.docs.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Expanded(
                                                                child: Card(
                                                              child: Container(
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) => ViewdataActivity2(
                                                                                  name: snapshot.data!.docs[index]['name'],
                                                                                  time_add: snapshot.data!.docs[index]['time_add'].toString(),
                                                                                  confirm: snapshot.data!.docs[index]['confirm_user'].toString(),
                                                                                  email: snapshot.data!.docs[index]['name_owner'],
                                                                                  day: snapshot.data!.docs[index]['day'].toString(),
                                                                                  time_go: snapshot.data!.docs[index]['time_go'].toString(),
                                                                                  locacion: snapshot.data!.docs[index]['locacion'].toString(),
                                                                                  user_go: snapshot.data!.docs[index]['user_go'],
                                                                                  detail: snapshot.data!.docs[index]['detail'],
                                                                                  uid: snapshot.data!.docs[index]['user_ID'],
                                                                                )));
                                                                  },
                                                                  child: Column(
                                                                      children: <
                                                                          Widget>[
                                                                        ListTile(
                                                                          title: Text(snapshot
                                                                              .data!
                                                                              .docs[index]['name']),
                                                                        )
                                                                      ]),
                                                                ),
                                                              ),
                                                            )),
                                                          ],
                                                        )
                                                      ],
                                                    );
                                                  })
                                            ],
                                          ),
                                        ),
                                      ),
                                      //     }),
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                      ));
                    }),
              );
            }));
  }
}
