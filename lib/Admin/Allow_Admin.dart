import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:volunteer/Admin/Home_Admin.dart';
import 'package:volunteer/Admin/PageHome/Infer.dart';
import 'package:volunteer/Admin/PageHome/Search.dart';

class AllowAdmin extends StatefulWidget {
  const AllowAdmin({Key? key}) : super(key: key);

  @override
  State<AllowAdmin> createState() => _AllowAdminState();
}

class _AllowAdminState extends State<AllowAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Allow Admin'),
        backgroundColor: Color.fromARGB(226, 140, 57, 248),
      ),
      body: ListView(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeAdmin()));
              },
              child: Text("อนุมัติ")),
        ],
      ),
    );
  }
}
