import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:volunteer/Admin/AddOwner.dart';

class ShowOwner extends StatefulWidget {
  const ShowOwner({Key? key}) : super(key: key);

  @override
  State<ShowOwner> createState() => _ShowOwnerState();
}

class _ShowOwnerState extends State<ShowOwner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('รายชื่อผู้จัดกิจกรรม'),
          backgroundColor: const Color.fromARGB(226, 140, 57, 248),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddOwner()));
                }),
          ]),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('User')
              .where("Role", isEqualTo: "Owner")
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: const CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
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
