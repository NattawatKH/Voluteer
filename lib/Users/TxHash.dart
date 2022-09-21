import 'package:flutter/material.dart';
import 'package:volunteer/Navigator/NaviUser.dart';
import 'package:volunteer/Users/Home_User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:volunteer/componance/Font.dart';

class Txhash extends StatefulWidget {
  const Txhash({
    Key? key,
    required this.txHash,
    required this.qrString,
  }) : super(key: key);
  final String txHash;
  final String qrString;

  @override
  State<Txhash> createState() => _TxhashState();
}

class _TxhashState extends State<Txhash> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'รหัสธุรกรรม',
                      style: Home_Allow_20,
                    ),
                    Padding(padding: EdgeInsetsDirectional.all(5)),
                    Text(
                      widget.txHash,
                      style: Home_Allow_20,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(225, 4, 0, 9),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeUser(),
                      ),
                    );
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => NavibarUser()));
                    print(
                        "Transactione hash = ${widget.txHash}"); //เช็ครหัสธุรกรรม
                    getTransaction(
                        context,
                        {
                          "Transaction": widget.txHash,
                        },
                        user!.uid);
                  },
                  child: Text('กลับไปหน้าแรก'),
                ),
              ),
            ],
          ),
        )));
  }

  //get transaction in Firebase
  Future<void> getTransaction(
      BuildContext context, Map<String, dynamic> data, String documentName) {
    return FirebaseFirestore.instance
        .collection("User")
        .doc(user!.uid)
        .collection("Transaction")
        .doc(widget.qrString)
        .update(data);
  }
}
