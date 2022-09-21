import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:volunteer/Owner/View_Data_ToQRCode.dart';

class ListOwner extends StatefulWidget {
  const ListOwner({Key? key}) : super(key: key);

  @override
  State<ListOwner> createState() => _ListOwnerState();
}

class _ListOwnerState extends State<ListOwner> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("รายการกิจกรรม"),
            backgroundColor: Color.fromARGB(226, 140, 57, 248),
            automaticallyImplyLeading: false,
          ),
          body: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Data')
                  .where("email_owner", isEqualTo: user!.email)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return SafeArea(
                    child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 236, 235, 235),
                      ),
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Card(
                              child: Container(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ViewDataQr(
                                                  name:
                                                      snapshot.data!.docs[index]
                                                          ['name_activity'],
                                                  time_add: snapshot.data!
                                                      .docs[index]['time_add']
                                                      .toString(),
                                                  confirm: snapshot
                                                      .data!
                                                      .docs[index]
                                                          ['confirm_form_admin']
                                                      .toString(),
                                                  email:
                                                      snapshot.data!.docs[index]
                                                          ['email_owner'],
                                                  day: snapshot
                                                      .data!.docs[index]['day']
                                                      .toString(),
                                                  time_go: snapshot.data!
                                                      .docs[index]['time_go']
                                                      .toString(),
                                                  locacion: snapshot.data!
                                                      .docs[index]['locacion']
                                                      .toString(),
                                                  user_go: snapshot.data!
                                                      .docs[index]['user_go'],
                                                  detail: snapshot.data!
                                                      .docs[index]['detail'],
                                                  uid: snapshot.data!
                                                      .docs[index]['uid_owner'],
                                                )));
                                  },
                                  child: Column(children: <Widget>[
                                    ListTile(
                                      title: Text(snapshot.data!.docs[index]
                                          ['name_activity']),
                                      trailing: (snapshot.data!.docs[index]
                                                  ['confirm_form_admin'] !=
                                              "1")
                                          ? Text("รอการอนุมัติ")
                                          : Text("อนุมัติแล้ว"),
                                    )
                                  ]),
                                ),
                              ),
                            ),
                          );
                        },
                      )),
                ));
              }),
        ));
  }
}
