import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:taartely_ui/pages/auth/welcome_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:taartely_ui/pages/buyer_component/contact/contact_page.dart';

class EmpatPage extends StatefulWidget {
  const EmpatPage({super.key});

  @override
  State<EmpatPage> createState() => _EmpatPageState();
}

class _EmpatPageState extends State<EmpatPage> {
  String baseUrl = dotenv.env["BASE_URL"] ?? "";
  late Future<User> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = _loadUser();
  }

  Future<User> _loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final url = Uri.parse('$baseUrl/users');
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['user'];
        return User.fromJson(data);
      } else {
        throw Exception('Failed to load user: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Failed to load user: $e');
      throw Exception('Failed to load user');
    }
  }

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final url = Uri.parse('$baseUrl/logout');
    try {
      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        await prefs.remove('token');
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => WelcomePage()),
          (route) => false,
        );
      } else {
        throw Exception('Failed to logout: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Failed to logout: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to logout: $e'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _navigateToContacts(BuildContext context) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ContactPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: FutureBuilder<User>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load user'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No user data found'));
          } else {
            User user = snapshot.data!;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Name: ${user.name}'),
                  Text('Email: ${user.email}'),
                  Text('Roles: ${user.roles}'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    child: Text("View Contacts"),
                    onPressed: () => _navigateToContacts(context),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    child: Text("Logout"),
                    onPressed: () => _logout(context),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class User {
  final String name;
  final String email;
  final String roles;

  User({required this.name, required this.email, required this.roles});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      roles: json['roles'],
    );
  }
}
