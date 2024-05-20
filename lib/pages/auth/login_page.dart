import 'package:flutter/material.dart';
import 'package:taartely_ui/pages/auth/register_page.dart';
import 'package:taartely_ui/pages/home_page.dart';

import '../admin/admin_home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _username = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:
          ThemeData(scaffoldBackgroundColor: Color.fromRGBO(255, 255, 255, 1)),
      home: Scaffold(
        appBar: AppBar(
          title: Container(
            margin: EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(16)),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(left: 34, top: 32),
                child: Text(
                  "Halo! Selamat bertemu denganmu lagi!",
                  style: TextStyle(
                      fontFamily: "Urbanist",
                      fontWeight: FontWeight.bold,
                      fontSize: 32),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 34, right: 34, top: 42),
                child: TextField(
                  controller: _username,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(232, 236, 244, 0))),
                      hintText: "Masukan username",
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(131, 145, 161, 1),
                        fontWeight: FontWeight.w500,
                        fontFamily: "Urbanist",
                      ),
                      fillColor: Color.fromRGBO(247, 248, 249, 1),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromRGBO(232, 236, 244, 0)),
                        borderRadius: BorderRadius.circular(12),
                      )),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 34, right: 34, top: 22),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(232, 236, 244, 0))),
                      hintText: "Masukan kata sandi",
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(131, 145, 161, 1),
                        fontWeight: FontWeight.w500,
                        fontFamily: "Urbanist",
                      ),
                      fillColor: Color.fromRGBO(247, 248, 249, 1),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromRGBO(232, 236, 244, 0)),
                        borderRadius: BorderRadius.circular(12),
                      )),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(left: 300, top: 16, bottom: 8),
                  child: Text(
                    "Lupa Sandi?",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Urbanist",
                        color: const Color.fromRGBO(106, 112, 124, 1)),
                  )),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromRGBO(30, 35, 44, 1)),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(vertical: 22.0, horizontal: 170.0),
                    ),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(
                            color: Color.fromRGBO(30, 35, 44, 1), width: 0.5),
                      ),
                    ),
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Urbanist",
                        color: const Color.fromARGB(255, 255, 255, 255)),
                  ),
                  onPressed: () {
                    if (_username.text == "Taartely") {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return AdminHomePage();
                      }));
                    } else{
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return HomePage();
                      }));
                    }
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return RegisterPage();
                  }));
                },
                child: Container(
                  padding: EdgeInsets.only(top: 350),
                  child: Text(
                    "Belum Punya Akun? Daftar",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        fontFamily: "Urbanist",
                        color: Color.fromRGBO(158, 21, 69, 1)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
