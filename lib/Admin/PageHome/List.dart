import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:volunteer/Admin/Allow_Admin_Confirm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Data")
              .where("confirm_form_admin", isEqualTo: "0")
              .snapshots(),
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
                                  builder: (context) => AllowAdminConfirm(
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
                                                    Navigator.pop(
                                                        context, 'ตกลง');
                                                    FirebaseFirestore.instance
                                                        .collection("Data")
                                                        .doc(snapshot.data!
                                                                .docs[index]
                                                            ['name_activity'])
                                                        .delete();
                                                  }),
                                            ],
                                          ),
                                        );
                                      }),
                                      icon: const Icon(Icons.delete))
                                ],
                              ),
                              subtitle: Text(
                                  snapshot.data!.docs[index]['email_owner']),
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

    // Scaffold(
    //   body: Center(
    //     child: ListView(
    //       children: [
    //         Card(
    //           child: InkWell(
    //             onTap: () => Navigator.push(
    //               context,
    //               MaterialPageRoute(builder: (context) => AllowAdmin()),
    //             ),
    //             child: Column(
    //               children: [
    //                 ListTile(
    //                   title: Text(snapshot.data!.docs[index]['confirm'] != 1
    //                       /? "รอการอนุมัติ"
    //                       : "อนุมัติแล้ว"),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
