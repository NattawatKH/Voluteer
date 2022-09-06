import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:volunteer/Admin/Allow_Admin.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
                  MaterialPageRoute(builder: (context) => AllowAdmin()),
                ),
                child: ListTile(
                    title: Text('กิจกรรม'),
                    subtitle: Text('คำอธิบาย'),
                    trailing: Text("ผ่าน")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
