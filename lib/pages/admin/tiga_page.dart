import 'package:flutter/material.dart';
import 'package:taartely_ui/pages/auth/welcome_page.dart';

class TigaPage extends StatefulWidget {
  const TigaPage({super.key});

  @override
  State<TigaPage> createState() => _TigaPageState();
}

class _TigaPageState extends State<TigaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("Logout"),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return WelcomePage();
            }));
          },
        ),
      ),
    );
  }
}
