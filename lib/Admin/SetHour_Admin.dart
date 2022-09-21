import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:volunteer/Admin/Home_Admin.dart';

class SetHourAdmin extends StatefulWidget {
  const SetHourAdmin({Key? key}) : super(key: key);

  @override
  State<SetHourAdmin> createState() => _SetHourAdminState();
}

class _SetHourAdminState extends State<SetHourAdmin> {
  final hour = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('กำหนดชั่วโมง'),
        backgroundColor: const Color.fromARGB(226, 140, 57, 248),
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: const Color.fromARGB(255, 236, 235, 235),
          ),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: "กำหนดชั่วโมง",
                    labelStyle:
                        const TextStyle(color: Colors.black, fontSize: 18),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(226, 140, 57, 248))),
                    hintText: "กรอกชั่วโมง",
                    border: const OutlineInputBorder(),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(15.0),
                  ),
                  controller: hour,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(225, 2, 2, 2),
                  ),
                  onPressed: () {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('ยืนยันการกำหนดชั่วโมง'),
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
                                    "hour": hour.text,
                                  },
                                  "SetHour_Admin",
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
        .doc("SetHour_Admin")
        .update(data);
  }
}
