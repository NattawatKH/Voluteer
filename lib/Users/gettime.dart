import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:volunteer/Navigator/NaviUser.dart';
import 'package:volunteer/Users/Time_User.dart';
import 'package:volunteer/Users/TxHash.dart';
import 'package:volunteer/componance/Font.dart';
import 'package:volunteer/serviec/contract.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:walletconnect_secure_storage/walletconnect_secure_storage.dart';
import 'package:web3dart/web3dart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fs;

class gettime extends StatefulWidget {
  const gettime({Key? key, required this.hour, required this.qrString})
      : super(key: key);
  final hour;
  final String qrString;

  @override
  State<gettime> createState() => _gettimeState();
}

class _gettimeState extends State<gettime> {
  User? user = FirebaseAuth.instance.currentUser;

  //Wallet Object
  late WalletConnect connector;
  String _account = '';
  bool? statusConnect;

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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            title: Text('ตรวจสอบเลขกระเป๋า'),
            backgroundColor: Color.fromARGB(226, 140, 57, 248),
            automaticallyImplyLeading: false,
          ),
          body: Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  Text(
                    'หมายเลขกระเป๋าของคุณ : ',
                    style: Home_Allow_20,
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  Text(
                    '${_account}',
                    style: Home_Allow_20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'ชั่วโมงที่ได้รับ : ${widget.hour.toString()}',
                    style: Home_Allow_20,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(225, 4, 0, 9),
                      ),
                      onPressed: () => getTime(_account),
                      child: Text('ยืนยันการรับชั่วโมง'),
                    ),
                  ),
                  // Center(
                  //   child: ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //       primary: Color.fromARGB(225, 4, 0, 9),
                  //     ),
                  //     onPressed: () {
                  //       print(widget.hour.runtimeType);
                  //     },
                  //     child: Text('test'),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ));
  }

  var txHash = '';
  //smart contract
  Future<String> getTime(String address) async {
    EthereumAddress ethAddress = EthereumAddress.fromHex(address);
    var timeget = BigInt.from(widget.hour);
    var response = await submit('getTime', [timeget, ethAddress]);
    print('AddTime started successfully');
    print("object = ${timeget}");
    txHash = response;
    setState(() {});
    print(txHash);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Txhash(
          qrString: widget.qrString,
          txHash: txHash,
        ),
      ),
    );

    return response;
  }

  //smart contract
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

  //smart contract
  Future<DeployedContract> loadContract() async {
    String abi = await rootBundle.loadString('assets/abi.json');
    String contractAddress = "0xdBf9d372fB9329dCdf79E2AE7597Ff4f2c424303";
    final contract = DeployedContract(ContractAbi.fromJson(abi, "volenteer"),
        EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  // //get transaction in Firebase
  // Future<void> getTransaction(
  //     BuildContext context, Map<String, dynamic> data, String documentName) {
  //   return fs.FirebaseFirestore.instance
  //       .collection("User")
  //       .doc(user!.uid)
  //       .collection("Transaction")
  //       .doc()
  //       .update(data);
  // }
}
