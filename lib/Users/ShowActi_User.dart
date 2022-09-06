import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class ShowActiUser extends StatefulWidget {
  const ShowActiUser({Key? key}) : super(key: key);

  @override
  State<ShowActiUser> createState() => _ShowActiUserState();
}

class _ShowActiUserState extends State<ShowActiUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show Activity User'),
        backgroundColor: Color.fromARGB(226, 140, 57, 248),
      ),
    );
  }
}
