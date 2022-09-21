import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:volunteer/Admin/AddUser.dart';

class ShowUser extends StatefulWidget {
  const ShowUser({Key? key}) : super(key: key);

  @override
  State<ShowUser> createState() => _ShowUserState();
}

class _ShowUserState extends State<ShowUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('รายชื่อผู้กู้ยืม'),
          backgroundColor: Color.fromARGB(226, 140, 57, 248),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddUser()));
                })
          ]),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('User')
              .where("Role", isEqualTo: "User")
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Card(
                    child: Container(
                      child: InkWell(
                        onTap: () {},
                        child: Column(children: <Widget>[
                          ListTile(
                            title: Text(snapshot.data!.docs[index]['email']),
                          )
                        ]),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
