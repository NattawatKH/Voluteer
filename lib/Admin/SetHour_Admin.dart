import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class SetHourAdmin extends StatefulWidget {
  const SetHourAdmin({Key? key}) : super(key: key);

  @override
  State<SetHourAdmin> createState() => _SetHourAdminState();
}

class _SetHourAdminState extends State<SetHourAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Hour'),
        backgroundColor: Color.fromARGB(226, 140, 57, 248),
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFF7C54ED),
          ),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "data",
                    hintText: "data",
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(15.0),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
