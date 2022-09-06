import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class ShowActiAdmin extends StatefulWidget {
  const ShowActiAdmin({Key? key}) : super(key: key);

  @override
  State<ShowActiAdmin> createState() => _ShowActiAdminState();
}

class _ShowActiAdminState extends State<ShowActiAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show All Admin'),
        backgroundColor: Color.fromARGB(226, 140, 57, 248),
      ),
      body: const Center(
        child: Text('All Activity'),
      ),
    );
  }
}
