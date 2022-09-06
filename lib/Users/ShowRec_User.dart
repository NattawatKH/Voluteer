import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class ShowRecUser extends StatefulWidget {
  const ShowRecUser({Key? key}) : super(key: key);

  @override
  State<ShowRecUser> createState() => _ShowRecUserState();
}

class _ShowRecUserState extends State<ShowRecUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show Rec User'),
        backgroundColor: Color.fromARGB(226, 140, 57, 248),
      ),
    );
  }
}
