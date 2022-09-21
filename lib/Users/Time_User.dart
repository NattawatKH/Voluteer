import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fs;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:volunteer/Users/ViewData_User2.dart';
import 'package:volunteer/Users/ViewData_UserTxHash.dart';
import 'package:volunteer/componance/Font.dart';
import 'package:volunteer/serviec/contract.dart';
import 'package:volunteer/serviec/Testfunction.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:walletconnect_secure_storage/walletconnect_secure_storage.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';

class TimeUser extends StatefulWidget {
  const TimeUser({
    Key? key,
  }) : super(key: key);

  @override
  State<TimeUser> createState() => _TimeUserState();
}

class _TimeUserState extends State<TimeUser> {
  User? user = FirebaseAuth.instance.currentUser;

  //Wallet Object
  late WalletConnect connector;
  String _account = '';
  bool? statusConnect;

  //Web3 Object
  bool data = false;
  var myTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: StreamBuilder(
            stream:
                fs.FirebaseFirestore.instance.collection("Admin").snapshots(),
            builder: (context, AsyncSnapshot<fs.QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Scaffold(
                appBar: AppBar(
                  title: const Text("เวลา"),
                  backgroundColor: const Color.fromARGB(226, 140, 57, 248),
                  automaticallyImplyLeading: false,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (snapshot.data!.docs[0]['alarm_add'] == 1)
                              const Text("ใกล้จะหมดเวลาส่งเอกสาร",
                                  style: const TextStyle(
                                    backgroundColor: Colors.red,
                                    color: Colors.white,
                                  ))
                            else
                              const Text(""),
                          ]),
                    )
                  ],
                ),
                body: SafeArea(
                  child: GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Container(
                              width: double.infinity,
                              height: 100,
                              decoration: const BoxDecoration(
                                color: const Color(0xFF7C54ED),
                              ),
                              child: Column(
                                // ListView(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 5, 0, 0),
                                    child: Container(
                                      width: double.infinity,
                                      height: 145,
                                      decoration: const BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 236, 235, 235),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(10, 3, 0, 0),
                                        child: Row(
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                if (myTime == null)
                                                  Text(
                                                      'ชั่วโมงที่ต้องการ : ${snapshot.data!.docs[1]['hour']} ชั่วโมง ')
                                                else
                                                  Text(
                                                      'ชั่วโมงที่ต้องการ : ${snapshot.data!.docs[1]['hour']} ชั่วโมง  สะสมไปแล้ว ${myTime} ชั่วโมง'),
                                                Text(
                                                    'กำหนดเวลา : ${snapshot.data!.docs[0]['day']}/${snapshot.data!.docs[0]['month']}/${snapshot.data!.docs[0]['year']}'),
                                                if (_account == "")
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: const Color
                                                                .fromARGB(
                                                            225, 4, 0, 9),
                                                      ),
                                                      onPressed: () async {
                                                        await createSession(
                                                            context);
                                                      },
                                                      child: const Text(
                                                          "เชื่อมต่อ Metamask"))
                                                else
                                                  Text(
                                                    'เชื่อมต่อ Wallet แล้ว : \n$_account',
                                                  ),
                                                /*Check hour --------------------------------
                                                 ElevatedButton(
                                                     onPressed: () {
                                                       print("data = ${myTime}");
                                                     },
                                                     child: Text("ดูชั่วโมง")),
                                                     ----------------------------------------
                                                */
                                                ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary:
                                                          const Color.fromARGB(
                                                              225, 4, 0, 9),
                                                    ),
                                                    onPressed: () =>
                                                        getBalance(_account),
                                                    child: const Text(
                                                        "ดูชั่วโมงสะสม")),
                                                /*Check  --------------------------------
                                                 ElevatedButton(
                                                     onPressed: () =>
                                                         getTime(_account),
                                                    child: Text("gettime")),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      AddTime(_account);
                                                      print("${tst}");
                                                    },
                                                    child: Text("tset add time")),
                                                     ----------------------------------------
                                                */
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            10, 8, 0, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          'ประวัติการทำกิจกรรม',
                                          style: Home_Onwer_15,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 0, 10, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      showDialog<String>(
                                                        context: context,
                                                        builder: (BuildContext
                                                                context) =>
                                                            AlertDialog(
                                                          title: const Text(
                                                              'รีเช็ตชั่วโมงหรือไม่'),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      context,
                                                                      'ยกเลิก'),
                                                              child: const Text(
                                                                  'ยกเลิก'),
                                                            ),
                                                            TextButton(
                                                                child:
                                                                    const Text(
                                                                        'ตกลง'),
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context,
                                                                      'ยกเลิก');
                                                                  setTime(
                                                                      _account);
                                                                }),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                    color: Colors.white,
                                                    icon: const Icon(
                                                        Icons.download))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  StreamBuilder(
                                      stream: fs.FirebaseFirestore.instance
                                          .collection('User')
                                          .doc(user!.uid)
                                          .collection("Transaction")
                                          .where("user_ID",
                                              isEqualTo: user!.uid)
                                          .snapshots(),
                                      builder: (context,
                                          AsyncSnapshot<fs.QuerySnapshot>
                                              snapshot) {
                                        if (!snapshot.hasData) {
                                          return const Center(
                                            child:
                                                const CircularProgressIndicator(),
                                          );
                                        }
                                        return Expanded(
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(10, 10, 10, 10),
                                            child: Column(
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
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Expanded(
                                                                  child: Card(
                                                                child:
                                                                    Container(
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => ViewdataActivitytxHash(
                                                                                    name: snapshot.data!.docs[index]['name'],
                                                                                    time_add: snapshot.data!.docs[index]['time_add'].toString(),
                                                                                    confirm: "ยืนยัน",
                                                                                    email: snapshot.data!.docs[index]['name_owner'],
                                                                                    day: snapshot.data!.docs[index]['day'].toString(),
                                                                                    time_go: snapshot.data!.docs[index]['time_go'].toString(),
                                                                                    locacion: snapshot.data!.docs[index]['locacion'].toString(),
                                                                                    user_go: snapshot.data!.docs[index]['user_go'],
                                                                                    detail: snapshot.data!.docs[index]['detail'],
                                                                                    uid: snapshot.data!.docs[index]['user_ID'],
                                                                                    txHash: snapshot.data!.docs[index]['Transaction'],
                                                                                  )));
                                                                      print(
                                                                        snapshot
                                                                            .data!
                                                                            .docs[index]['Transaction'],
                                                                      );
                                                                    },
                                                                    child: Column(
                                                                        children: <
                                                                            Widget>[
                                                                          ListTile(
                                                                            title:
                                                                                Text(snapshot.data!.docs[index]['name']),
                                                                            trailing:
                                                                                Text(snapshot.data!.docs[index]['user_go']),
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
                                        );
                                      })
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }));
  }

  //ตัวแปรที่ใช้เก็บเฉยๆ ไว้ส่งไปมา
  var _session;
  var _connector;
  var _uri;

  //TODO 1: เชื่อมต่อ Wallet (Create new session)
  createSession(BuildContext context) async {
    //TODO 1.1: กรณีที่ยังไม่เชื่อมต่อ wallet
    if (statusConnect == false) {
      final sessionStorage = WalletConnectSecureStorage();
      final session = await sessionStorage.getSession();

      //Wallet Seesion
      var connector = WalletConnect(
        bridge: 'https://bridge.walletconnect.org',
        session: session,
        sessionStorage: sessionStorage,
        clientMeta: const PeerMeta(
            name: 'TestMode',
            description: 'Connect application for lightWallet',
            url: 'https://walletconnect.org',
            icons: [
              'https://files.gitbook.com/v0/b/gitbook-legacy-files/o/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
            ]),
      );

      //เช็คก่อนว่า connector เชื่อมต่อหรือยังป้องกัน error
      if (!connector.connected) {
        try {
          //Create a new session
          //  * onDisplayUri = bridge: 'https://bridge.walletconnect.org'
          //  * bridge.walletconnect.org = ศูนย์กลางของ wallet มากมายที่สามารถเชื่อมต่อกับ bloackchain ได้
          final session =
              await connector.createSession(onDisplayUri: (uri) async {
            _uri = uri;
            //เรียกเปิด app wallet ที่ต้องการใช้เชื่อม
            await launchUrlString(uri, mode: LaunchMode.externalApplication);
          });
          print("Connect Session: $session");

          //set sessionData, account
          setState(() {
            _account = session.accounts.first;
            _session = session;
            _connector = connector;
            if (_account == '') {
              statusConnect = true;
            }
          });

          //set data เมื่อเชื่อมต่อได้เรียบร้อย
          connector.registerListeners(
            onConnect: (status) {
              setState(() {
                _account = status.accounts[0];
                _session = session;
                _connector = connector;
              });
            },
          );
        } catch (err) {
          print("Connect Error: $err");
        }
      }

      //TODO 1.2: กรณีที่เคยเชื่อมต่อ wallet มาแล้ว
    } else {
      //เช็คก่อนได้เชื่อมต่อ wallet หรือยัง?
      if (!connector.connected) {
        try {
          //Create a new session
          //  * onDisplayUri = bridge: 'https://bridge.walletconnect.org'
          //  * bridge.walletconnect.org = ศูนย์กลางของ wallet มากมายที่สามารถเชื่อมต่อกับ bloackchain ได้
          final session =
              await connector.createSession(onDisplayUri: (uri) async {
            _uri = uri;
            //เรียกเปิด app wallet ที่ต้องการใช้เชื่อม
            await launchUrlString(uri, mode: LaunchMode.externalApplication);
          });
          print("Connect Session: $session");
          print("_uri: $_uri");
          //set sessionData
          setState(() {
            _session = session;
            _connector = connector;
          });
        } catch (err) {
          print("Connect Error: $err");
        }
      }
    }
  }

  //TODO 2: User Wallet
  Future initWalletConnect() async {
    // Define a session storage
    final sessionStorage = WalletConnectSecureStorage();
    final session = await sessionStorage.getSession();

    //เชื่อมต่อ wallet ผ่านตัว walletconnect.org
    var connector = WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      session: session,
      sessionStorage: sessionStorage,
      clientMeta: const PeerMeta(
          name: 'TestMode',
          description: 'Connect application for lightWallet',
          url: 'https://walletconnect.org',
          icons: [
            'https://files.gitbook.com/v0/b/gitbook-legacy-files/o/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
          ]),
    );
    //set address
    setState(() {
      _account = session?.accounts.first ?? '';
      if (_account == '') {
        statusConnect = false;
      } else {
        _session = session;
        _connector = connector;
        statusConnect = true;
      }
    });

    //show address เมื่อเชื่อมต่อเรียบร้อย
    connector.registerListeners(
      onConnect: (status) {
        setState(() {
          _account = status.accounts[0];
        });
      },
    );

    print("_account = $_account");

    //print("connector.accounts = ${connector.session.accounts[0]}");
  }

  late Client timeuser;
  late Web3Client ethClient;

  @override
  void initState() {
    super.initState();
    initWalletConnect();
    timeuser = Client();
    ethClient = Web3Client(Infura_url, timeuser);
  }

  Future<DeployedContract> loadContract() async {
    String abi = await rootBundle.loadString('assets/abi.json');
    String contractAddress = "0xdBf9d372fB9329dCdf79E2AE7597Ff4f2c424303";
    final contract = DeployedContract(ContractAbi.fromJson(abi, "volenteer"),
        EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  //ดึงสัญญาณมาเรียกใช้ funstion

  Future<List<dynamic>> query(String funcname, List<dynamic> args) async {
    final contract = await loadContract();
    final ethFunction = contract.function(funcname);
    final result = await ethClient.call(
        contract: contract, function: ethFunction, params: args);
    return result;
  }

  Future<void> getBalance(String address) async {
    EthereumAddress ethAddress = EthereumAddress.fromHex(address);

    List<dynamic> result = await query("getBalance", [ethAddress]);

    print("aaa = ${result[0]}");
    print("bbb = ${_account}");
    print("ccc = ${myTime}");
    setState(() {
      data = true;
      myTime = result[0];
    });
  }

  var txHash;

  Future<String> setTime(String address) async {
    EthereumAddress ethAddress = EthereumAddress.fromHex(address);

    var response = await submit('setTime', [ethAddress]);
    print('AddTime started successfully');
    print('Transaction hash: $response');

    txHash = response;
    setState(() {});
    return response;
  }

  // Future<List> getTime(String address) async {
  //   List<dynamic> response = await submit('AddTime', [myTime]);
  //   print('AddTime started successfully');

  //   return response;
  // }

  Future<String> submit(String funcname, List<dynamic> args) async {
    EthPrivateKey credentials = EthPrivateKey.fromHex(User_private);

    DeployedContract contract = await loadContract();
    final ethFunction = contract.function(funcname);
    final result = await ethClient.sendTransaction(
        credentials,
        Transaction.callContract(
            contract: contract,
            function: ethFunction,
            parameters: args,
            maxGas: 100000),
        fetchChainIdFromNetworkId: false,
        chainId: 3);
    print(User_private);
    return result;
  }
}
