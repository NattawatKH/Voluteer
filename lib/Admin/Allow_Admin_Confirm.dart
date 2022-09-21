import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:volunteer/Admin/Home_Admin.dart';
import 'package:volunteer/Admin/PageHome/Infer.dart';
import 'package:volunteer/Admin/PageHome/List.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:volunteer/componance/Font.dart';

class AllowAdminConfirm extends StatefulWidget {
  const AllowAdminConfirm(
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
  State<AllowAdminConfirm> createState() => _AllowAdminConfirmState();
}

class _AllowAdminConfirmState extends State<AllowAdminConfirm> {
  String time = "PP......";
  int _confirm = 0;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("Data")
        .doc(widget.name)
        .get()
        .then((value) {
      setState(() {
        time = value.data()!["time_add"];
        _confirm = value.data()!["confirm_form_admin"];
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
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(225, 4, 0, 9),
                  ),
                  onPressed: () {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('คุณต้องการอนุมัติกิจกรรมหรือไม่'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'ยกเลิก'),
                            child: const Text('ยกเลิก'),
                          ),
                          TextButton(
                              child: const Text('ตกลง'),
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection("Data")
                                    .doc(widget.name)
                                    .update({"confirm_form_admin": "1"});
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('อนุมัติแล้ว')));
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
                  child: const Text("อนุมัติ")),
            ),
          ],
        ),
      ),
    );
  }
}
