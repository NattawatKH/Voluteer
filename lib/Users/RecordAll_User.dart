import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class RecrodAllUser extends StatefulWidget {
  const RecrodAllUser({Key? key}) : super(key: key);

  @override
  State<RecrodAllUser> createState() => _RecrodAllUserState();
}

class _RecrodAllUserState extends State<RecrodAllUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Record All User'),
        backgroundColor: Color.fromARGB(226, 140, 57, 248),
      ),
    );
  }
}
