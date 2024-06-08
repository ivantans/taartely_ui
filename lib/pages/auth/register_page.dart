import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:taartely_ui/pages/auth/login_page.dart';
import 'package:taartely_ui/model/register.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  String baseUrl = dotenv.env["BASE_URL"] ?? "";
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _validatePasswordController = TextEditingController();
  bool _isLoading = false;

  void _showError(String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final snackBar = SnackBar(content: Text(message));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  Future<void> register(String name, String email, String password) async {
    setState(() {
      _isLoading = true;
    });
    if (_validatePasswordController.text != password) {
      _showError("Konfirmasi kata sandi salah");
      return;
    }
    final response = await http.post(
      Uri.parse("$baseUrl/register"),
      body: {
        "name": name,
        "email": email,
        "password": password
      },
    );
    setState(() {
      _isLoading = false;
    });
    if (response.statusCode == 201) {
      final responseJson = json.decode(response.body);
      RegisterResponse registerResponse = RegisterResponse.fromJson(responseJson);
      if (registerResponse.success) {
        _showError("Berhasil Register");
      } else {
        _showError(registerResponse.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
      ),
      body: _isLoading?_buildLoading():_buildBody(context)
    );
  }

    Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }


  Widget _buildBody(BuildContext context){
    return SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildTitle(),
              _buildTextField(_nameController, "Name"),
              _buildTextField(_emailController, "Email"),
              _buildTextField(_passwordController, "Kata sandi", obscureText: true),
              _buildTextField(_validatePasswordController, "Konfirmasi kata sandi", obscureText: true),
              _buildRegisterButton(),
              _buildLoginText(context),
            ],
          ),
        ),
      );
  }
  Widget _buildTitle() {
    return Container(
      padding: EdgeInsets.only(left: 34, top: 32),
      child: Text(
        "Halo! Ayo mendaftar untuk memulai!",
        style: TextStyle(
          fontFamily: "Urbanist",
          fontWeight: FontWeight.bold,
          fontSize: 32,
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText, {bool obscureText = false}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 34, vertical: 12),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color.fromRGBO(232, 236, 244, 0)),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Color.fromRGBO(131, 145, 161, 1),
            fontWeight: FontWeight.w500,
            fontFamily: "Urbanist",
          ),
          fillColor: Color.fromRGBO(247, 248, 249, 1),
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(232, 236, 244, 0)),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(30, 35, 44, 1)),
          padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.symmetric(vertical: 22.0, horizontal: 170.0),
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
            color: Colors.white,
          ),
        ),
        onPressed: () {
          register(_nameController.text, _emailController.text, _passwordController.text);
        },
      ),
    );
  }

  Widget _buildLoginText(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      },
      child: Container(
        padding: EdgeInsets.only(top: 260),
        child: Text(
          "Sudah Punya Akun? Masuk",
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
