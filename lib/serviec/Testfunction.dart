import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:volunteer/serviec/contract.dart';
import 'package:web3dart/web3dart.dart';
import 'package:volunteer/Users/Home_User.dart';
import 'package:http/http.dart';

class Functionss extends StatefulWidget {
  const Functionss({Key? key, required this.account}) : super(key: key);
  final account;

  @override
  State<Functionss> createState() => _FunctionState();
}

class _FunctionState extends State<Functionss> {
  late Client timeuser;
  late Web3Client ethClient;
  var myTime;

  @override
  void initState() {
    timeuser = Client();
    ethClient = Web3Client(Infura_url, timeuser);
    getBalance(widget.account);
    super.initState();
  }

  Future<DeployedContract> loadContract() async {
    String abi = await rootBundle.loadString('assets/abi.json');
    String contractAddress = "0xD9173731429561e23702842fF78ce52Af198D1E0";
    final contract = DeployedContract(ContractAbi.fromJson(abi, 'volenteer'),
        EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  Future<List<dynamic>> query(String funcname, List<dynamic> args) async {
    final contract = await loadContract();
    final ethFunction = contract.function(funcname);
    final result = await ethClient.call(
        contract: contract, function: ethFunction, params: args);
    return result;
  }

  Future<void> getBalance(String address) async {
    // EthereumAddress ethAddress = EthereumAddress.fromHex(address);

    List<dynamic> result = await query("getBalance", []);

    print("aaa = ${result[0]}");
    setState(() {
      myTime = result[0];
    });
  }

  Future<List> getTime(String address) async {
    List<dynamic> response = (await submit('getTime', [myTime])) as List;
    print('AddTime started successfully');

    return response;
  }

  Future<String> submit(String funcname, List<dynamic> args) async {
    EthPrivateKey credentials = EthPrivateKey.fromHex(widget.account);

    DeployedContract contract = await loadContract();
    final ethFunction = contract.function(funcname);
    final result = await ethClient.sendTransaction(
        credentials,
        Transaction.callContract(
            contract: contract, function: ethFunction, parameters: args));
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {},
              child: Text("${myTime}"),
            )
          ],
        ),
      ),
    );
  }
}
