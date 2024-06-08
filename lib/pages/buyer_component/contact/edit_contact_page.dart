import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'contact_page.dart';

class EditContactPage extends StatefulWidget {
  final Contact contact;

  const EditContactPage({super.key, required this.contact});

  @override
  State<EditContactPage> createState() => _EditContactPageState();
}

class _EditContactPageState extends State<EditContactPage> {
  String baseUrl = dotenv.env["BASE_URL"] ?? "";
  final _formKey = GlobalKey<FormState>();
  late String _userAddress;
  late String _userPhoneNumber;

  @override
  void initState() {
    super.initState();
    _userAddress = widget.contact.userAddress;
    _userPhoneNumber = widget.contact.userPhoneNumber;
  }

  Future<void> _updateContact() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final url = Uri.parse('$baseUrl/contacts/${widget.contact.id}');
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'user_address': _userAddress,
          'user_phone_number': _userPhoneNumber,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Contact updated successfully'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
        Navigator.pop(context);
      } else {
        var responseData = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update contact: ${responseData['message']}'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print('Failed to update contact: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update contact: $e'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await _updateContact();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Contact"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _userAddress,
                decoration: InputDecoration(labelText: 'User Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a user address';
                  }
                  return null;
                },
                onSaved: (value) {
                  _userAddress = value!;
                },
              ),
              TextFormField(
                initialValue: _userPhoneNumber,
                decoration: InputDecoration(labelText: 'User Phone Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a user phone number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _userPhoneNumber = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Update Contact'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
