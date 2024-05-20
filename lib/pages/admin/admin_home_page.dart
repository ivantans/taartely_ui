import 'package:flutter/material.dart';
import 'package:taartely_ui/pages/admin/dua_page.dart';
import 'package:taartely_ui/pages/admin/satu_page.dart';
import 'package:taartely_ui/pages/admin/tiga_page.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int currentIndex = 0;
    List screens = [
      SatuPage(),
      DuaPage(),
      TigaPage()
      
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (value){
            setState(() {
              currentIndex = value;
            });
          },
          selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled, size: 35,), label: "Beranda"),
          BottomNavigationBarItem(icon: Icon(Icons.sticky_note_2_outlined, size: 35,), label: "Pesanan"),
          BottomNavigationBarItem(icon: Icon(Icons.person, size: 35,), label: "Profil"),
        ],
        ),
      ),

    );
  }
}