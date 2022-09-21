import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:volunteer/Navigator/NaviOwner.dart';
import 'package:volunteer/Owner/List_Owner.dart';
import 'package:volunteer/componance/Font.dart';

class Viewdata extends StatefulWidget {
  const Viewdata(
      {Key? key,
      required this.name,
      required this.time_add,
      required this.day,
      required this.time_go,
      required this.locacion,
      required this.user_go,
      required this.detail})
      : super(key: key);
  final name;
  final time_add;
  final day;
  final time_go;
  final locacion;
  final user_go;
  final detail;

  @override
  State<Viewdata> createState() => _ViewdataState();
}

class _ViewdataState extends State<Viewdata> {
  User? user = FirebaseAuth.instance.currentUser;
  String uid = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ส่งคำขอสร้างกิจกรรม"),
        backgroundColor: const Color.fromARGB(226, 140, 57, 248),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('data').snapshots(),
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
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 10, 20, 0),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(5),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(5),
                                ),
                                Text(
                                  "ชื่อกิจกรรม : ${widget.name}",
                                  style: Home_Allow_20,
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(5),
                                ),
                                Text(
                                  "ชั่วโมงที่ได้รับ : ${widget.time_add}",
                                  style: Home_Allow_20,
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(5),
                                ),
                                Text(
                                  "วันที่จัดกิจกรรม :  ${widget.day}",
                                  style: Home_Allow_20,
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(5),
                                ),
                                Text(
                                  "เวลาที่จัดกิจกรรม : ${widget.time_go}",
                                  style: Home_Allow_20,
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(5),
                                ),
                                Text(
                                  "สถานที่จัดกิจกรรม : ${widget.locacion}",
                                  style: Home_Allow_20,
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(5),
                                ),
                                Text(
                                  "จำนวนผู้เข้าร่วมกิจกรรม : ${widget.user_go}",
                                  style: Home_Allow_20,
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(5),
                                ),
                                Text(
                                  "รายละเอียดกิจกรรม : ${widget.detail}",
                                  style: Home_Allow_20,
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(5),
                                ),
                                Column(
                                  children: [
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: const Color.fromARGB(
                                                225, 4, 0, 9),
                                          ),
                                          onPressed: () {
                                            showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                title: const Text(
                                                    'ยืนยันการส่งคำขอสร้างกิจกรรม'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            context, 'ยกเลิก'),
                                                    child: const Text('ยกเลิก'),
                                                  ),
                                                  TextButton(
                                                      child: const Text('ตกลง'),
                                                      onPressed: () {
                                                        if (widget.name == "" ||
                                                            widget.time_add ==
                                                                "" ||
                                                            widget.day == "" ||
                                                            widget.time_go ==
                                                                "" ||
                                                            widget.locacion ==
                                                                "" ||
                                                            widget.user_go ==
                                                                "" ||
                                                            widget.detail ==
                                                                "") {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  const SnackBar(
                                                                      content: Text(
                                                                          'กรุณากรอกข้อมูลให้ครบ')));
                                                        } else {
                                                          addItem(
                                                              context,
                                                              {
                                                                "confirm_form_admin":
                                                                    "0",
                                                                "name_activity":
                                                                    widget.name,
                                                                "time_add": widget
                                                                    .time_add,
                                                                "day":
                                                                    widget.day,
                                                                "time_go": widget
                                                                    .time_go,
                                                                "locacion": widget
                                                                    .locacion,
                                                                "user_go": widget
                                                                    .user_go,
                                                                "detail": widget
                                                                    .detail,
                                                                "email_owner":
                                                                    user?.email,
                                                                "uid_owner":
                                                                    user?.uid,
                                                              },
                                                              widget.name);

                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  const SnackBar(
                                                                      content: Text(
                                                                          'เพิ่มข้อมูลสำเร็จ')));

                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const ListOwner()),
                                                          );
                                                          Navigator.of(context)
                                                              .pushReplacement(
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              const NavibarOwner()));
                                                        }
                                                      }),
                                                ],
                                              ),
                                            );
                                          },
                                          child: const Text("ส่งคำขอ"),
                                        ),
                                      ),
                                    ),
                                    // ElevatedButton(
                                    //   style: ElevatedButton.styleFrom(
                                    //     primary: Color.fromARGB(225, 4, 0, 9),
                                    //   ),
                                    //   onPressed: () => _showNotification(),
                                    //   child: const Text("tset"),
                                    // ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ));
          }),
    );
  }

  // ฟังก์ชันเพิ่มข้อมูล
  Future<void> addItem(
      BuildContext context, Map<String, dynamic> data, String documentName) {
    return FirebaseFirestore.instance
        .collection("Data")
        .doc(widget.name)
        .set(data);
  }

  Future<void> addItem_Inuser(
      BuildContext context, Map<String, dynamic> data, String documentName) {
    return FirebaseFirestore.instance
        .collection("User")
        .doc(documentName)
        .update(data)
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> _showNotification() async {}
}
