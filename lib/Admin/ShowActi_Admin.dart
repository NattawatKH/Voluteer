import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:volunteer/Admin/Allow_Admin_View.dart';

class ShowActiAdmin extends StatefulWidget {
  const ShowActiAdmin({Key? key}) : super(key: key);

  @override
  State<ShowActiAdmin> createState() => _ShowActiAdminState();
}

class _ShowActiAdminState extends State<ShowActiAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('กิจกรรมทั้งหมด'),
        backgroundColor: const Color.fromARGB(226, 140, 57, 248),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Data").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: Text("Please wait..."),
              );
            }
            var doc = snapshot.data!.docs;
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Container(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllowAdminView(
                                        name: snapshot.data!.docs[index]
                                            ['name_activity'],
                                        time_add: snapshot
                                            .data!.docs[index]['time_add']
                                            .toString(),
                                        confirm: snapshot.data!
                                            .docs[index]['confirm_form_admin']
                                            .toString(),
                                        email: snapshot.data!.docs[index]
                                            ['email_owner'],
                                        day: snapshot.data!.docs[index]['day']
                                            .toString(),
                                        time_go: snapshot
                                            .data!.docs[index]['time_go']
                                            .toString(),
                                        locacion: snapshot
                                            .data!.docs[index]['locacion']
                                            .toString(),
                                        user_go: snapshot.data!.docs[index]
                                            ['user_go'],
                                        detail: snapshot.data!.docs[index]
                                            ['detail'],
                                        uid: snapshot.data!.docs[index]
                                            ['uid_owner'],
                                      )));
                        },
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                  snapshot.data!.docs[index]['name_activity']),
                              trailing: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  (snapshot.data!.docs[index]
                                              ['confirm_form_admin'] !=
                                          "1")
                                      ? const Text("รอการอนุมัติ")
                                      : const Text(
                                          "อนุมัติแล้ว",
                                        ),
                                  IconButton(
                                      onPressed: (() {
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            title: const Text(
                                                'คุณต้องการลบกิจกรรมนี้หรือไม่'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'ยกเลิก'),
                                                child: const Text('ยกเลิก'),
                                              ),
                                              TextButton(
                                                  child: const Text('ตกลง'),
                                                  onPressed: () {
                                                    FirebaseFirestore.instance
                                                        .collection("Data")
                                                        .doc(snapshot.data!
                                                                .docs[index]
                                                            ['name_activity'])
                                                        .delete();
                                                    Navigator.pop(
                                                        context, 'ตกลง');
                                                  }),
                                            ],
                                          ),
                                        );
                                      }),
                                      icon: const Icon(Icons.delete))
                                ],
                              ),
                              subtitle: Text(snapshot
                                  .data!.docs[index]['email_owner']
                                  .toString()),
                            ),
                          ],
                        ),
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
