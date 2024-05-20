import 'package:flutter/material.dart';
import 'package:taartely_ui/pages/auth/welcome_page.dart';

class EmpatPage extends StatefulWidget {
  const EmpatPage({super.key});

  @override
  State<EmpatPage> createState() => _EmpatPageState();
}

class _EmpatPageState extends State<EmpatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: ElevatedButton(child: Text("Logout"), onPressed: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
          return WelcomePage();
        }));
      },)),

    );
  }
}