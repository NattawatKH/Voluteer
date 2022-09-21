// ignore_for_file: unnecessary_const

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:volunteer/Admin/Home_Admin.dart';
import 'package:volunteer/componance/Font.dart';

class SetDayDocu extends StatefulWidget {
  const SetDayDocu({Key? key}) : super(key: key);

  @override
  State<SetDayDocu> createState() => _SetDayDocuState();
}

class _SetDayDocuState extends State<SetDayDocu> {
  final day = TextEditingController();
  final month = TextEditingController();
  final year = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('กำหนดวันส่งเอกสาร'),
        backgroundColor: const Color.fromARGB(226, 140, 57, 248),
        actions: [
          IconButton(
              onPressed: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('แจ้งเตือนกำหนดวันส่งเอกสาร'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, 'ปิดการแจ้งเตือน');
                          alarm_add(context, {"alarm_add": 0}, "SetDoc_Admin");
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('ปิดการแจ้งเตือนเรียบร้อย')));
                        },
                        child: const Text('ปิดการแจ้งเตือน'),
                      ),
                      TextButton(
                          child: const Text('เปิดการแจ้งเตือน'),
                          onPressed: () {
                            Navigator.pop(context, 'เปิดการแจ้งเตือน');
                            alarm_add(
                                context, {"alarm_add": 1}, "SetDoc_Admin");
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('เปิดการแจ้งเตือนเรียบร้อย')));
                          }),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.alarm_add))
        ],
      ),
      body: Container(
          decoration: const BoxDecoration(
            color: const Color.fromARGB(255, 236, 235, 235),
          ),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: "วันที่กำหนดส่งเอกสาร",
                    labelStyle: TextStyle(color: Colors.black, fontSize: 18),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(226, 140, 57, 248))),
                    hintText: "กรอกวันที่",
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(),
                  ),
                  controller: day,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: "เดือนที่กำหนดส่งเอกสาร",
                    labelStyle: TextStyle(color: Colors.black, fontSize: 18),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(226, 140, 57, 248))),
                    hintText: "กรอกเดือน",
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(),
                  ),
                  controller: month,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: "ปีที่กำหนดส่งเอกสาร",
                    labelStyle: TextStyle(color: Colors.black, fontSize: 18),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: const Color.fromARGB(226, 140, 57, 248))),
                    hintText: "กรอกปี",
                    fillColor: Colors.white,
                    filled: true,
                    border: const OutlineInputBorder(),
                  ),
                  controller: year,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(225, 4, 0, 9),
                  ),
                  onPressed: () {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('ยืนยันการกำหนดวันส่งเอกสาร'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'ยกเลิก'),
                            child: const Text('ยกเลิก'),
                          ),
                          TextButton(
                              child: const Text('ตกลง'),
                              onPressed: () {
                                AddDataToUser(
                                  context,
                                  {
                                    "day": day.text,
                                    "month": month.text,
                                    "year": year.text,
                                  },
                                  "SetDoc_Admin",
                                );
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeAdmin()));
                              }),
                        ],
                      ),
                    );
                  },
                  child: const Text('บันทึก'),
                ),
              ),
            ],
          )),
    );
  }

  Future<void> AddDataToUser(
      BuildContext context, Map<String, dynamic> data, String documentName) {
    return FirebaseFirestore.instance
        .collection("Admin")
        .doc("SetDoc_Admin")
        .update(data);
  }

  Future<void> alarm_add(
      BuildContext context, Map<String, dynamic> data, String documentName) {
    return FirebaseFirestore.instance
        .collection("Admin")
        .doc("SetDoc_Admin")
        .update(data);
  }
}
