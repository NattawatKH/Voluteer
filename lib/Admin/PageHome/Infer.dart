import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:volunteer/Admin/ShowOwner_Admin.dart';
import 'package:volunteer/Admin/ShowUser_Admin.dart';
import 'package:volunteer/Users/ShowActi_User.dart';

class InferPage extends StatefulWidget {
  const InferPage({Key? key}) : super(key: key);

  @override
  State<InferPage> createState() => _InferPageState();
}

class _InferPageState extends State<InferPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            Card(
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShowActiUser()),
                ),
                child: ListTile(
                  title: Text('กิจกรรมทั้งหมด'),
                  subtitle: Text('ดูกิจกรรมทั้งหมด'),
                ),
              ),
            ),
            Card(
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShowOwner()),
                ),
                child: ListTile(
                  title: Text('รายชื่อผู้จัดกิจกรรม'),
                  subtitle: Text('ดูรายชื่อผู้จัดกิจกรรมทั้งหมด'),
                ),
              ),
            ),
            Card(
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShowUser()),
                ),
                child: ListTile(
                  title: Text('รายชื่อนิสิต'),
                  subtitle: Text('ดูรายชื่อนิสิตทั้งหมด'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
