import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taartely_ui/pages/auth/register_page.dart';
import 'package:taartely_ui/pages/navbar/buyer/buyer_navbar.dart';
import 'package:taartely_ui/model/login.dart';
import '../navbar/admin/admin_navbar.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String baseUrl = dotenv.env["BASE_URL"] ?? "";
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false; // Variable to track loading state

  Future<void> login(String email, String password) async {
    setState(() {
      _isLoading = true; // Start loading animation
    });
    // https://cbd1-114-122-116-42.ngrok-free.app/api/login
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      body: {
        "email": email,
        "password": password,
      },
    );

    setState(() {
      _isLoading = false; // Stop loading animation
    });

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      LoginResponse loginResponse = LoginResponse.fromJson(responseJson);

      if (loginResponse.success) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', loginResponse.token!);

        // Verify if the token is successfully stored
        String? storedToken = prefs.getString('token');
        if (storedToken != null && storedToken == loginResponse.token) {
          print('Token successfully stored: $storedToken');

          // Navigate to the respective page based on the user's role
          if (loginResponse.user!.roles == "seller") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AdminHomePage()),
            );
          } else if (loginResponse.user!.roles == "buyer") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else {
            _showError("Invalid role");
          }
        } else {
          _showError("Failed to store token");
        }
      } else {
        _showError(loginResponse.message);
      }
    } else {
      _showError("Failed to login");
    }
  }

  void _showError(String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final snackBar = SnackBar(content: Text(message));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _isLoading ? _buildLoading() : _buildBody(context), // Display loading or body
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false, // Removes the default back button
      title: Container(
        margin: EdgeInsets.only(left: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(16),
        ),
        child: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildGreetingText(),
            _buildEmailTextField(),
            _buildPasswordTextField(),
            _buildForgotPasswordText(),
            _buildLoginButton(),
            _buildRegisterText(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildGreetingText() {
    return Container(
      padding: EdgeInsets.only(left: 34, top: 32),
      child: Text(
        "Halo! Selamat bertemu denganmu lagi!",
        style: TextStyle(
          fontFamily: "Urbanist",
          fontWeight: FontWeight.bold,
          fontSize: 32,
        ),
      ),
    );
  }

  Widget _buildEmailTextField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 34, vertical: 22),
      child: TextField(
        controller: _emailController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          hintText: "Masukan username",
          hintStyle: TextStyle(
            color: Color.fromRGBO(131, 145, 161, 1),
            fontWeight: FontWeight.w500,
            fontFamily: "Urbanist",
          ),
          fillColor: Color.fromRGBO(247, 248, 249, 1),
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 34),
      child: TextField(
        controller: _passwordController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          hintText: "Masukan kata sandi",
          hintStyle: TextStyle(
            color: Color.fromRGBO(131, 145, 161, 1),
            fontWeight: FontWeight.w500,
            fontFamily: "Urbanist",
          ),
          fillColor: Color.fromRGBO(247, 248, 249, 1),
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        obscureText: true, // Add this line to obscure the password
      ),
    );
  }

  Widget _buildForgotPasswordText() {
    return Container(
      padding: EdgeInsets.only(left: 300, top: 16, bottom: 8),
      child: Text(
        "Lupa Sandi?",
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          fontFamily: "Urbanist",
          color: Color.fromRGBO(106, 112, 124, 1),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Container(
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
            color: Colors.white,
          ),
        ),
        onPressed: () {
          login(_emailController.text, _passwordController.text);
        },
      ),
    );
  }

  Widget _buildRegisterText(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => RegisterPage()),
        );
      },
      child: Container(
        padding: EdgeInsets.only(top: 350),
        child: Text(
          "Belum Punya Akun? Daftar",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w900,
            fontFamily: "Urbanist",
            color: Color.fromRGBO(158, 21, 69, 1),
          ),
        ),
      ),
    );
  }
}
