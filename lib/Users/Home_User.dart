import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:volunteer/Users/QrCode_User.dart';
import 'package:volunteer/Users/ViewData_User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:volunteer/componance/Font.dart';
import 'package:volunteer/serviec/contract.dart';
import 'package:web3dart/web3dart.dart';

class HomeUser extends StatefulWidget {
  const HomeUser({Key? key}) : super(key: key);

  @override
  State<HomeUser> createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {
  User? user = FirebaseAuth.instance.currentUser;
  String qrString = 'Not Scannde';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("User")
                .doc(user!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: const Color.fromARGB(226, 140, 57, 248),
                  automaticallyImplyLeading: false,
                  title: Container(
                    child: Text(user!.email.toString()),
                  ),
                ),
                body: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Data')
                        // .doc(user!.uid)
                        // .collection('Activity')
                        .where("confirm_form_admin", isEqualTo: "1")
                        // .where("${user!.uid}", isNotEqualTo: "userID")
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: const CircularProgressIndicator(),
                        );
                      }
                      return SafeArea(
                          child: GestureDetector(
                        onTap: () => FocusScope.of(context).unfocus(),
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 236, 235, 235),
                          ),
                          child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(10, 10, 10, 0),
                                              child: Container(
                                                width: 100,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFF984BF9),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                              10, 0, 0, 0),
                                                      child: Text(
                                                        'กิจกรรม',
                                                        style: Home_Onwer_15,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(10, 10, 10, 10),
                                          child: ListView(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            children: [
                                              ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: snapshot
                                                      .data!.docs.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Expanded(
                                                                child: Card(
                                                              child: Container(
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) => ViewdataActivity(
                                                                                  name: snapshot.data!.docs[index]['name_activity'].toString(),
                                                                                  time_add: snapshot.data!.docs[index]['time_add'],
                                                                                  confirm: snapshot.data!.docs[index]['confirm_form_admin'].toString(),
                                                                                  email: snapshot.data!.docs[index]['email_owner'].toString(),
                                                                                  day: snapshot.data!.docs[index]['day'].toString(),
                                                                                  time_go: snapshot.data!.docs[index]['time_go'].toString(),
                                                                                  locacion: snapshot.data!.docs[index]['locacion'].toString(),
                                                                                  user_go: snapshot.data!.docs[index]['user_go'].toString(),
                                                                                  detail: snapshot.data!.docs[index]['detail'].toString(),
                                                                                  uid: snapshot.data!.docs[index]['uid_owner'].toString(),
                                                                                )));
                                                                  },
                                                                  child: Column(
                                                                      children: <
                                                                          Widget>[
                                                                        ListTile(
                                                                          title: Text(snapshot
                                                                              .data!
                                                                              .docs[index]['name_activity']),
                                                                          trailing: Text(snapshot
                                                                              .data!
                                                                              .docs[index]['user_go']),
                                                                        )
                                                                      ]),
                                                                ),
                                                              ),
                                                            )),
                                                          ],
                                                        )
                                                      ],
                                                    );
                                                  })
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                      ));
                    }),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    scanQR();
                  },
                  backgroundColor: const Color(0xFF7C54ED),
                  elevation: 8,
                  child: const Icon(
                    Icons.qr_code_scanner,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              );
            }));
  }

  Future<void> scanQR() async {
    try {
      FlutterBarcodeScanner.scanBarcode("#2A99CF", "", true, ScanMode.QR)
          .then((value) {
        setState(() {
          qrString = value;
        });
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => QrCodeUser(
                    qrString: qrString.toString(),
                  )));
      print("asas= $qrString");
    } catch (e) {
      setState(() {
        qrString = "unble";
      });
    }
  }
}
