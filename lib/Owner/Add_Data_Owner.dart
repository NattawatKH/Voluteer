import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:volunteer/Owner/ViewData.dart';
import 'package:volunteer/componance/Font.dart';
import 'package:google_fonts/google_fonts.dart';

class AddDataOwner extends StatefulWidget {
  const AddDataOwner({Key? key}) : super(key: key);

  @override
  State<AddDataOwner> createState() => _AddDataOwnerState();
}

class _AddDataOwnerState extends State<AddDataOwner> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final time_add = TextEditingController();
  final day = TextEditingController();
  final time_go = TextEditingController();
  final locacion = TextEditingController();
  final user_go = TextEditingController();
  final detail = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: FutureBuilder(
            future: FirebaseFirestore.instance.collection("data").get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  appBar: AppBar(
                      backgroundColor: const Color.fromARGB(226, 140, 57, 248),
                      title: const Text('Error')),
                  body: Center(child: Text("${snapshot.error}")),
                );
              }
              if (snapshot.hasData) {
                return Scaffold(
                    appBar: AppBar(
                      title: const Text("สร้างกิจกรรม"),
                      backgroundColor: const Color.fromARGB(226, 140, 57, 248),
                      automaticallyImplyLeading: false,
                    ),
                    body: SafeArea(
                        child: GestureDetector(
                      onTap: () => FocusScope.of(context).unfocus(),
                      child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: const BoxDecoration(
                            color: const Color.fromARGB(255, 236, 235, 235),
                          ),
                          child: ListView(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Form(
                                  key: formKey,
                                  child: Container(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            20, 10, 20, 0),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'ชื่อกิจกรรม',
                                            style: Add_Data_5,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),

                                          // ignore: duplicate_ignore
                                          TextFormField(
                                            decoration: const InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          226, 140, 57, 248))),
                                              border: OutlineInputBorder(),
                                              filled: true,
                                              fillColor: Colors.white,
                                              hintText: 'กรอกชื่อกิจกรรม',
                                            ),
                                            // ignore: non_constant_identifier_names
                                            controller: name,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'ชั่วโมงที่ได้รับ',
                                            style: Add_Data_5,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          TextFormField(
                                            decoration: const InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          226, 140, 57, 248))),
                                              border: OutlineInputBorder(),
                                              filled: true,
                                              fillColor: Colors.white,
                                              hintText: 'กำหนดชั่วโมงที่ได้รับ',
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: time_add,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'วันที่',
                                            style: Add_Data_5,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          TextFormField(
                                            decoration: const InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          226, 140, 57, 248))),
                                              border: OutlineInputBorder(),
                                              filled: true,
                                              fillColor: Colors.white,
                                              hintText: 'กรอกวันที่',
                                            ),
                                            // ignore: non_constant_identifier_names
                                            controller: day,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'เวลา',
                                            style: Add_Data_5,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          TextFormField(
                                            decoration: const InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          226, 140, 57, 248))),
                                              border: OutlineInputBorder(),
                                              filled: true,
                                              fillColor: Colors.white,
                                              hintText: 'กำหนดเวลา',
                                            ),
                                            // ignore: non_constant_identifier_names
                                            controller: time_go,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'สถานที่',
                                            style: Add_Data_5,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          TextFormField(
                                            decoration: const InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          226, 140, 57, 248))),
                                              border: OutlineInputBorder(),
                                              filled: true,
                                              fillColor: Colors.white,
                                              hintText: 'กรอกสถานที่',
                                            ),
                                            // ignore: non_constant_identifier_names
                                            controller: locacion,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'จำนวนผู้เข้าร่วม',
                                            style: Add_Data_5,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          TextFormField(
                                            decoration: const InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          226, 140, 57, 248))),
                                              border: OutlineInputBorder(),
                                              filled: true,
                                              fillColor: Colors.white,
                                              hintText: 'กำหนดจำนวนผู้เข้าร่วม',
                                            ),
                                            // ignore: non_constant_identifier_names
                                            controller: user_go,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'รายระเอียด',
                                            style: Add_Data_5,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          TextFormField(
                                            decoration: const InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          226, 140, 57, 248))),
                                              border: OutlineInputBorder(),
                                              filled: true,
                                              fillColor: Colors.white,
                                              hintText: 'กรอกรายระเอียด',
                                            ),
                                            // ignore: non_constant_identifier_names
                                            controller: detail,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Column(
                                            children: [
                                              Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary:
                                                          const Color.fromARGB(
                                                              225, 4, 0, 9),
                                                    ),
                                                    onPressed: () {
                                                      if (name.text == "" ||
                                                          time_add.text == "" ||
                                                          day.text == "" ||
                                                          time_go.text == "" ||
                                                          locacion.text == "" ||
                                                          user_go.text == "" ||
                                                          detail.text == "") {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                const SnackBar(
                                                                    content: Text(
                                                                        'กรุณากรอกข้อมูลให้ครบ')));
                                                      } else {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      Viewdata(
                                                                        name: name
                                                                            .text,
                                                                        time_add:
                                                                            time_add.text,
                                                                        day: day
                                                                            .text,
                                                                        time_go:
                                                                            time_go.text,
                                                                        locacion:
                                                                            locacion.text,
                                                                        user_go:
                                                                            user_go.text,
                                                                        detail:
                                                                            detail.text,
                                                                      )),
                                                        );
                                                      }
                                                    },
                                                    child: const Text("บันทึก"),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    )));
              }
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }));
  }
}
