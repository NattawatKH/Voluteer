import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:volunteer/Admin/Home_Admin.dart';
import 'package:volunteer/Admin/PageHome/Infer.dart';
import 'package:volunteer/Admin/PageHome/List.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:volunteer/componance/Font.dart';

class AllowAdminView extends StatefulWidget {
  const AllowAdminView(
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
  State<AllowAdminView> createState() => _AllowAdminViewState();
}

class _AllowAdminViewState extends State<AllowAdminView> {
  String time = "PP......";
  int _confirm = 1;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("data")
        .doc(widget.uid)
        .get()
        .then((value) {
      setState(() {
        time = value.data()!["time_add"];
        _confirm = value.data()!["confirm"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: const Color.fromARGB(226, 140, 57, 248),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 20,
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
            Text("ชั่วโมงที่ได้รับ :  ${widget.time_add}",
                style: Home_Allow_20),
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
              "รายละเอียดกิจกรรม :  ${widget.detail}",
              style: Home_Allow_20,
            ),
            const Padding(
              padding: EdgeInsets.all(20),
            ),
          ],
        ),
      ),
    );
  }
}
