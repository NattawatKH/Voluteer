import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:volunteer/Admin/ShowActi_Admin.dart';
import 'package:volunteer/Admin/ShowOwner_Admin.dart';
import 'package:volunteer/Admin/ShowUser_Admin.dart';
import 'package:volunteer/componance/Font.dart';

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
                  MaterialPageRoute(
                      builder: (context) => const ShowActiAdmin()),
                ),
                child: ListTile(
                  title: Text(
                    'กิจกรรมทั้งหมด',
                    style: Home_Indur_List_18,
                  ),
                  subtitle: const Text(
                    'ดูกิจกรรมทั้งหมด',
                  ),
                ),
              ),
            ),
            Card(
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ShowOwner()),
                ),
                child: ListTile(
                  title: Text(
                    'รายชื่อผู้จัดกิจกรรม',
                    style: Home_Indur_List_18,
                  ),
                  subtitle: const Text('ดูรายชื่อผู้จัดกิจกรรมทั้งหมด'),
                ),
              ),
            ),
            Card(
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ShowUser()),
                ),
                child: ListTile(
                  title: Text(
                    'รายชื่อผู้กู้ยืมกยศ.',
                    style: Home_Indur_List_18,
                  ),
                  subtitle: const Text('ดูรายชื่อนิสิตทั้งหมด'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
