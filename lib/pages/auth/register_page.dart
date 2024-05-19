import 'package:flutter/material.dart';
import 'package:taartely_ui/pages/auth/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                  "Halo! Ayo mendaftar untuk memulai!",
                  style: TextStyle(
                      fontFamily: "Urbanist",
                      fontWeight: FontWeight.bold,
                      fontSize: 32),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 34, right: 34, top: 42),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(232, 236, 244, 0))),
                      hintText: "Username",
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
                margin: EdgeInsets.only(left: 34, right: 34, top: 12),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(232, 236, 244, 0))),
                      hintText: "Email",
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
                margin: EdgeInsets.only(left: 34, right: 34, top: 12),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(232, 236, 244, 0))),
                      hintText: "Kata sandi",
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
                margin: EdgeInsets.only(left: 34, right: 34, top: 12),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(232, 236, 244, 0))),
                      hintText: "Konfirmasi kata sandi",
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
                    "Daftar",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Urbanist",
                        color: const Color.fromARGB(255, 255, 255, 255)),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                    return LoginPage();
                  }));
                  },
                ),
              ), GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                    return LoginPage();
                  }));
                },
                child: Container(
                  padding: EdgeInsets.only(top: 260),
                  child: Text(
                    "Sudah Punya Akun? Masuk",
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
