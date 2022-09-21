import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:volunteer/Navigator/NaviUser.dart';
import 'package:volunteer/Users/Home_User.dart';
import 'package:volunteer/Users/Time_User.dart';
import 'package:volunteer/Users/gettime.dart';
import 'package:volunteer/componance/Font.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:volunteer/serviec/contract.dart';
import 'package:volunteer/serviec/Testfunction.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';

class QrCodeUser extends StatefulWidget {
  const QrCodeUser({Key? key, required this.qrString}) : super(key: key);
  final String qrString;

  @override
  State<QrCodeUser> createState() => _QrCodeUserState();
}

class _QrCodeUserState extends State<QrCodeUser> {
  User? user = FirebaseAuth.instance.currentUser;

  Web3Client? Hour;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(226, 140, 57, 248),
          title: Container(
            child: Text("กิจกรรม"),
          ),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('User')
                .doc(user!.uid)
                .collection("Activity")
                .where("name", isEqualTo: "${widget.qrString}")
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot activity = snapshot.data!.docs[index];
                      final time = activity['time_add'];
                      return Container(
                          height: 663,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 236, 235, 235),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 50, 10, 10),
                            child: ListView(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          "ชื่อกิจกรรม : ${activity['name']}",
                                          style: Home_Allow_20,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          "ชั่วโมงที่ได้รับ :  ${activity['time_add']}",
                                          style: Home_Allow_20,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          "วันที่จัดกิจกรรม : ${activity['day']}",
                                          style: Home_Allow_20,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          "เวลาที่จัดกิจกรรม : ${activity['time_go']}",
                                          style: Home_Allow_20,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          "สถานที่จัดกิจกรรม : ${activity['locacion']}",
                                          style: Home_Allow_20,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          "จำนวนผู้เข้าร่วมกิจกรรม  :  ${activity['user_go']}",
                                          style: Home_Allow_20,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          "รายละเอียดกิจกรรม : ${activity['detail']}",
                                          style: Home_Allow_20,
                                        ),
                                      ),
                                    ],
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Color.fromARGB(255, 0, 0, 0),
                                      onPrimary: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    onPressed: () {
                                      if (activity['completed'] == "1") {
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            title: const Text(
                                                'คุณได้รับชั่วโมงแล้ว'),
                                            actions: <Widget>[
                                              TextButton(
                                                  child: const Text(
                                                      'กลับไปหน้าหลัก'),
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            HomeUser(),
                                                      ),
                                                    );
                                                    Navigator.of(context)
                                                        .pushReplacement(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        NavibarUser()));
                                                  }),
                                            ],
                                          ),
                                        );
                                        print(activity['completed']);
                                      } else {
                                        get_time_user(
                                            context,
                                            {
                                              "name": activity['name'],
                                              "time_add": activity['time_add'],
                                              "day": activity['day'],
                                              "time_go": activity['time_go'],
                                              "locacion": activity['locacion'],
                                              "user_go": activity['user_go'],
                                              "detail": activity['detail'],
                                              "user_ID": user!.uid,
                                              "name_owner":
                                                  activity['name_owner'],
                                            },
                                            user!.uid);
                                        get_time_user_completed(
                                            context,
                                            {
                                              "completed": "1",
                                            },
                                            user!.uid);

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => gettime(
                                                    hour: int.parse(
                                                        "${activity['time_add']}"),
                                                    qrString:
                                                        widget.qrString)));
                                        /*Check-----------------------------------
                                         print(activity['time_add'].runtimeType);
                                         -----------------------------------------
                                        */
                                      }
                                    },
                                    child: Text("ยืนยัน"),
                                  ),
                                ]),
                          ));
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }

  Future<void> get_time_user(
      BuildContext context, Map<String, dynamic> data, String documentName) {
    return FirebaseFirestore.instance
        .collection("User")
        .doc(user!.uid)
        .collection("Transaction")
        .doc(widget.qrString)
        .set(data);
  }

  Future<void> get_time_user_completed(
      BuildContext context, Map<String, dynamic> data, String documentName) {
    return FirebaseFirestore.instance
        .collection("User")
        .doc(user!.uid)
        .collection("Activity")
        .doc(widget.qrString)
        .update(data);
  }
}
