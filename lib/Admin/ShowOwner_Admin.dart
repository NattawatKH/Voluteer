import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ShowOwner extends StatefulWidget {
  const ShowOwner({Key? key}) : super(key: key);

  @override
  State<ShowOwner> createState() => _ShowOwnerState();
}

class _ShowOwnerState extends State<ShowOwner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show All Owner'),
        backgroundColor: Color.fromARGB(226, 140, 57, 248),
      ),
      body: const Center(
        child: Text('All Owner'),
      ),
    );
  }
}
