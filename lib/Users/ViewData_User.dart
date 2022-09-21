import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:volunteer/Users/Gen_data_user.dart';
import 'package:volunteer/componance/Font.dart';

class ViewdataActivity extends StatefulWidget {
  const ViewdataActivity(
      {Key? key,
      required this.name,
      required this.time_add,
      required this.confirm,
      required this.email,
      required this.day,
      required this.time_go,
      required this.locacion,
      required this.user_go,
      required this.detail,
      required this.uid})
      : super(key: key);
  final String name;
  final String time_add;
  final String confirm;
  final String email;
  final String day;
  final String time_go;
  final String locacion;
  final String user_go;
  final String detail;
  final String uid;

  @override
  State<ViewdataActivity> createState() => _ViewdataActivityState();
}

class _ViewdataActivityState extends State<ViewdataActivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
          backgroundColor: Color.fromARGB(226, 140, 57, 248),
        ),
        body: SafeArea(
            child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 236, 235, 235),
            ),
            child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 80, 10, 10),
                            child: ListView(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "ชื่อกิจกรรม : ${widget.name}",
                                          style: Home_Allow_20,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(5),
                                        ),
                                        Text(
                                          "ชั่วโมงที่ได้รับ :  ${widget.time_add}",
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
                                          "เวลาที่จัดกิจกรรม :  ${widget.time_go}",
                                          style: Home_Allow_20,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(5),
                                        ),
                                        Text(
                                          "สถานที่จัดกิจกรรม:  ${widget.locacion}",
                                          style: Home_Allow_20,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(5),
                                        ),
                                        Text(
                                          "จำนวนผู้เข้าร่วมกิจกรรม  :  ${widget.user_go}",
                                          style: Home_Allow_20,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(5),
                                        ),
                                        Text(
                                          "ผู้จัดกิจกรรม :  ${widget.email}",
                                          style: Home_Allow_20,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(5),
                                        ),
                                        Text(
                                          "รายละเอียดกิจกรรม :  ${widget.detail}",
                                          style: Home_Allow_20,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(20),
                                        ),
                                      ],
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        onPrimary: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    GenDataUser(
                                                      name: widget.name,
                                                      email: widget.email,
                                                      user_go: widget.user_go,
                                                      time_add: widget.time_add,
                                                      day: widget.day,
                                                      time_go: widget.time_go,
                                                      locacion: widget.locacion,
                                                      detail: widget.detail,
                                                      uid: widget.uid,
                                                      confirm: widget.confirm,
                                                    )));
                                      },
                                      child: const Text(
                                          "ลงทะเบียนเข้าร่วมกิจกรรม"),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
        )));
  }

  // Future<void> Adduser_Indata(
  //     BuildContext context, Map<String, dynamic> data, String documentName) {
  //   return FirebaseFirestore.instance.collection("User").doc(user!.uid).set(
  //         data,
  //         SetOptions(merge: true),
  //       );
  // }
}
