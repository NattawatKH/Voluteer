import 'package:flutter/material.dart';
import 'package:volunteer/Users/Home_User.dart';
import 'package:volunteer/Users/List_User.dart';
import 'package:volunteer/Users/Setting_User.dart';
import 'package:volunteer/Users/Time_User.dart';

class NavibarUser extends StatefulWidget {
  const NavibarUser({Key? key}) : super(key: key);

  @override
  State<NavibarUser> createState() => _NavibarUserState();
}

class _NavibarUserState extends State<NavibarUser> {
  int currentIndex = 0;
  final screens = [
    HomeUser(),
    TimeUser(),
    ListUser(),
    SetUser(),
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
            icon: Icon(Icons.access_time),
            label: 'เวลา',
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
