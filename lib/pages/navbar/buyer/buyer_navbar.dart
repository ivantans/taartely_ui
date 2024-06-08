import 'package:flutter/material.dart';
import 'package:taartely_ui/pages/navbar/buyer/navbar_component/cart_page.dart';
import 'package:taartely_ui/pages/navbar/buyer/navbar_component/profile_page.dart';
import 'package:taartely_ui/pages/navbar/buyer/navbar_component/dashboard_page.dart';
import 'package:taartely_ui/pages/navbar/buyer/navbar_component/order_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  List screens = [
    const SatuPage(),
    const DuaPage(),
    const TigaPage(),
    const EmpatPage()
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Container(
            margin: EdgeInsets.only(left: 12),
            child: Text(
              "Taartely",
              style: TextStyle(
                  fontFamily: "Urbanist",
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            )),
      ),
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
          BottomNavigationBarItem(icon: Icon(Icons.home_filled, size: 30,), label: "Beranda"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined, size: 30,), label: "Keranjang"),
          BottomNavigationBarItem(icon: Icon(Icons.sticky_note_2_outlined, size: 30,), label: "Pesanan"),
          BottomNavigationBarItem(icon: Icon(Icons.person, size: 30,), label: "Profil"),
        ],
      ),
    ));
  }
}
