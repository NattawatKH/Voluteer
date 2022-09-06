import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class SetDayDocu extends StatefulWidget {
  const SetDayDocu({Key? key}) : super(key: key);

  @override
  State<SetDayDocu> createState() => _SetDayDocuState();
}

class _SetDayDocuState extends State<SetDayDocu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Day Docu'),
        backgroundColor: Color.fromARGB(226, 140, 57, 248),
      ),
      body: Container(
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
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "data",
                    hintText: "data",
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "data",
                    hintText: "data",
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
