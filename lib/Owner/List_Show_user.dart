import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Listuser extends StatefulWidget {
  const Listuser({
    Key? key,
  }) : super(key: key);

  @override
  State<Listuser> createState() => _ListuserState();
}

class _ListuserState extends State<Listuser> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("รายชื่อผู้เข้าร่วมกิจกรรม"),
        backgroundColor: const Color.fromARGB(226, 140, 57, 248),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('User')
              .doc(user!.uid)
              .collection('Activity')
              .where("confirm_user", isEqualTo: "1")
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
                              child: Column(children: <Widget>[
                                ListTile(
                                  title: Text(
                                      snapshot.data!.docs[index]["user_name"]),
                                  trailing: Text(snapshot
                                      .data!.docs[index]["num_user"]
                                      .toString()),
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
    );
  }
}
