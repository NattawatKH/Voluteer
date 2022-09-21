import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ShowAlertOwner extends StatefulWidget {
  const ShowAlertOwner({Key? key}) : super(key: key);

  @override
  State<ShowAlertOwner> createState() => _ShowAlertOwnerState();
}

class _ShowAlertOwnerState extends State<ShowAlertOwner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Show"),
        backgroundColor: const Color.fromARGB(226, 140, 57, 248),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: const Color(0xFF7C54ED),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    'รายชื่อผู้เข้าร่วม',
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text(
                          'ลำดับที่',
                        ),
                        Text(
                          'ชื่อ',
                        ),
                        Text(
                          'รหัสนิสิต',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Text(
                                'Hello World',
                              ),
                              Text(
                                'Hello World',
                              ),
                              Text(
                                'Hello World',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
