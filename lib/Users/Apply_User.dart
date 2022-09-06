import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class ApplyUser extends StatefulWidget {
  const ApplyUser({Key? key}) : super(key: key);

  @override
  State<ApplyUser> createState() => _ApplyUserState();
}

class _ApplyUserState extends State<ApplyUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ApplyUser'),
        backgroundColor: Color.fromARGB(226, 140, 57, 248),
      ),
    );
  }
}
