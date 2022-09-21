import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:volunteer/Database/Auth.dart';
import 'package:volunteer/Login.dart';

class SetUser extends StatefulWidget {
  const SetUser({Key? key}) : super(key: key);

  @override
  State<SetUser> createState() => _SetUserState();
}

class _SetUserState extends State<SetUser> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("ตั้งค่า"),
            backgroundColor: Color.fromARGB(226, 140, 57, 248),
            automaticallyImplyLeading: false,
          ),
          body: ListView(
            children: [
              GestureDetector(
                onTap: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('ออกจากระบบ'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'ยกเลิก'),
                          child: const Text('ยกเลิก'),
                        ),
                        TextButton(
                            child: const Text('ตกลง'),
                            onPressed: () {
                              _auth.Logout(context);
                            }),
                      ],
                    ),
                  );
                },
                child: const Card(
                  child: ListTile(
                    trailing: Icon(Icons.logout),
                    title: Text("ออกจากระบบ"),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
