import 'package:flutter/material.dart';
import 'package:taartely_ui/pages/auth/login_page.dart';
import 'package:taartely_ui/pages/auth/register_page.dart';
import 'package:taartely_ui/pages/navbar/buyer/buyer_navbar.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 550,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  "images/awal.png",
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                width: 170,
                child: Image.asset(
                  "images/logotaartely.png",
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 50),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromRGBO(158, 21, 69, 1)),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(vertical: 24.0, horizontal: 170.0),
                    ),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  child: Text(
                    "Masuk",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Urbanist",
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return LoginPage();
                    }));
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.white),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(vertical: 24.0, horizontal: 170.0),
                    ),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(color: Color.fromRGBO(30, 35, 44, 1), width: 0.5),
                        
                      ),
                    ),
                  ),
                  child: Text(
                    "Daftar",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Urbanist",
                      color: Colors.black
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return RegisterPage();
                    }));
                  },
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                    return HomePage();
                  }));
                },
                child: Container(
                  padding: EdgeInsets.only(top: 75),
                  child: Text(
                    "Continue as a guest",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
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