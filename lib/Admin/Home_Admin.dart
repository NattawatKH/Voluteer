import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:volunteer/Admin/PageHome/Infer.dart';
import 'package:volunteer/Admin/PageHome/Search.dart';
import 'package:volunteer/Admin/SetDoc_Admin.dart';
import 'package:volunteer/Admin/SetHour_Admin.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({Key? key}) : super(key: key);

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFA46EE8),
          title: Container(
            clipBehavior: Clip.antiAlias,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Cat03.jpg/1200px-Cat03.jpg',
              fit: BoxFit.fill,
            ),
          ),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.newspaper),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SetDayDocu()));
                }),
            IconButton(
                icon: const Icon(Icons.access_time),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SetHourAdmin()));
                }),
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                text: "สรุป",
              ),
              Tab(text: "รายการคำขอ"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            InferPage(),
            SearchPage(),
          ],
        ),
      ),
    );
  }
}
