import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrOwnerCode extends StatefulWidget {
  const QrOwnerCode({
    Key? key,
    required this.name,
    required this.time_add,
    required this.confirm,
    required this.email,
    required this.day,
    required this.time_go,
    required this.locacion,
    required this.user_go,
    required this.detail,
    required this.uid,
  }) : super(key: key);
  final String name;
  final String time_add;
  final String confirm;
  final String email;
  final String day;
  final String time_go;
  final String locacion;
  final String user_go;
  final String detail;
  final String uid;

  @override
  State<QrOwnerCode> createState() => _QrOwnerCodeState();
}

class _QrOwnerCodeState extends State<QrOwnerCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("QR Code"),
          backgroundColor: Color.fromARGB(226, 140, 57, 248),
          actions: <Widget>[
            IconButton(icon: const Icon(Icons.save_alt), onPressed: () {}),
          ]),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            QrImage(
              data: widget.name,
              version: QrVersions.auto,
              size: 200.0,
            ),
          ],
        ),
      ),
    );
  }
}
