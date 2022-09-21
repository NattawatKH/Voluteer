import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:volunteer/Owner/List_Show_user.dart';
import 'package:volunteer/componance/Font.dart';

class HomeOwner extends StatefulWidget {
  const HomeOwner({Key? key}) : super(key: key);

  @override
  State<HomeOwner> createState() => _HomeOwnerState();
}

class _HomeOwnerState extends State<HomeOwner> {
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
                  backgroundColor: const Color.fromARGB(226, 140, 57, 248),
                  automaticallyImplyLeading: false,
                  title: Container(
                    child: Text(user!.email.toString()),
                  ),
                ),
                body: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Data')
                        .where("uid_owner", isEqualTo: user!.uid)
                        .where("confirm_form_admin", isEqualTo: "1")
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: const CircularProgressIndicator(),
                        );
                      }
                      return SafeArea(
                        child: GestureDetector(
                          onTap: () => FocusScope.of(context).unfocus(),
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: const BoxDecoration(
                              color: const Color.fromARGB(255, 236, 235, 235),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(10, 10, 10, 0),
                                              child: Container(
                                                width: 100,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFF984BF9),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                              10, 0, 0, 0),
                                                      child: Text(
                                                        'กิจกรรม',
                                                        style: Home_Onwer_15,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                0, 0, 10, 0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            40, 5, 40, 5),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(10, 0, 10, 10),
                                          child: ListView(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          10, 10, 10, 10),
                                                  child: ListView(
                                                    padding: EdgeInsets.zero,
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    children: [
                                                      ListView.builder(
                                                          shrinkWrap: true,
                                                          itemCount: snapshot
                                                              .data!
                                                              .docs
                                                              .length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Expanded(
                                                                        child:
                                                                            Card(
                                                                      child:
                                                                          Container(
                                                                        child:
                                                                            InkWell(
                                                                          onTap:
                                                                              () {
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => const Listuser()));
                                                                            print(snapshot.data!.docs[index]['name']);
                                                                          },
                                                                          child:
                                                                              Column(children: <Widget>[
                                                                            ListTile(
                                                                              title: Text(snapshot.data!.docs[index]['name_activity']),
                                                                              trailing: Text(snapshot.data!.docs[index]['user_go']),
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
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              );
            }));
  }
}
