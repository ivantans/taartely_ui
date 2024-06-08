import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EditCategoryPage extends StatefulWidget {
  final int categoryId;
  final String categoryName;

  EditCategoryPage({required this.categoryId, required this.categoryName});

  @override
  _EditCategoryPageState createState() => _EditCategoryPageState();
}

class _EditCategoryPageState extends State<EditCategoryPage> {
  String baseUrl = dotenv.env["BASE_URL"] ?? "";
  final _formKey = GlobalKey<FormState>();
  late String _categoryName;

  @override
  void initState() {
    super.initState();
    _categoryName = widget.categoryName;
  }

  Future<void> _updateCategory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final url = Uri.parse('$baseUrl/categories/${widget.categoryId}');
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'product_category_name': _categoryName}),
      );

      print('Update Category Response status: ${response.statusCode}');
      print('Update Category Response body: ${response.body}');
      
      if (response.statusCode == 200) {
        print('Category updated successfully');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Category updated successfully'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        var responseData = json.decode(response.body);
        print('Failed to update category: ${responseData['message']}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update category: ${responseData['message']}'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print('Failed to update category: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update category: $e'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await _updateCategory();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 12, right: 12),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(16)),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Text(
              "Edit Kategori",
              style: TextStyle(
                fontFamily: "Urbanist",
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20),
              TextFormField(
                initialValue: _categoryName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color.fromRGBO(232, 236, 244, 0)),
                  ),
                  hintText: "Nama kategori",
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _categoryName = value!;
                },
              ),
              SizedBox(height: 20),
              Spacer(),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(
                  "Update kategori",
                  style: TextStyle(
                    fontFamily: "Urbanist",
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 130),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
