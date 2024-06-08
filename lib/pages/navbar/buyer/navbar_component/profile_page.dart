import 'package:flutter/material.dart';
import 'package:taartely_ui/pages/auth/welcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmpatPage extends StatefulWidget {
  const EmpatPage({super.key});

  @override
  State<EmpatPage> createState() => _EmpatPageState();
}

class _EmpatPageState extends State<EmpatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
        child: Text("Logout"),
        onPressed: () async {
          await _logout(context);
        },
      )),
    );
  }
}

Future<void> _logout(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('token');
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => WelcomePage()),
    (route) => false,
  );
}
