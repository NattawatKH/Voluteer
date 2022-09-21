import 'package:flutter/material.dart';
import 'package:volunteer/Owner/Add_Data_Owner.dart';
import 'package:volunteer/Owner/Home_Owner.dart';
import 'package:volunteer/Owner/List_Owner.dart';
import 'package:volunteer/Owner/Setting_Owner.dart';
import 'package:volunteer/Users/List_User.dart';
import 'package:volunteer/Users/Setting_User.dart';
import 'package:volunteer/Users/Time_User.dart';

class NavibarOwner extends StatefulWidget {
  const NavibarOwner({Key? key}) : super(key: key);

  @override
  State<NavibarOwner> createState() => _NavibarOwnerState();
}

class _NavibarOwnerState extends State<NavibarOwner> {
  int currentIndex = 0;
  final screens = [
    HomeOwner(),
    AddDataOwner(),
    ListOwner(),
    SetOwner(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        iconSize: 35,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'หน้าหลัก',
            backgroundColor: Color.fromARGB(226, 140, 57, 248),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'เพิ่มข้อมูล',
            backgroundColor: Color.fromARGB(226, 140, 57, 248),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'รายการ',
            backgroundColor: Color.fromARGB(226, 140, 57, 248),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'ตั้งค่า',
            backgroundColor: Color.fromARGB(226, 140, 57, 248),
          ),
        ],
      ),
    );
  }
}
