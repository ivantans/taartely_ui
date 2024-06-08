import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taartely_ui/model/add_product_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  String baseUrl = dotenv.env["BASE_URL"] ?? "";
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  List<XFile> _selectedImages = [];

  String _name = '';
  double _price = 0.0;
  int _categoryId = 0;
  String _description = '';
  String _composision = '';
  List<Category> _categories = [];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      final response = await http.get(
        Uri.parse('$baseUrl/categories'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        setState(() {
          _categories = data.map((json) => Category.fromJson(json)).toList();
        });
      } else {
        throw Exception('Failed to load categories: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Failed to load categories: $e');
    }
  }

  Future<void> _createProduct(Product product) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final url = Uri.parse('$baseUrl/products');

    try {
      var request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Bearer $token';

      // Add fields to the request
      request.fields['product_name'] = product.name;
      request.fields['product_price'] = product.price.toString();
      request.fields['product_category_id'] = product.categoryId.toString();
      request.fields['product_description'] = product.description;
      request.fields['product_composision'] = product.composision;

      // Add images to the request
      for (var image in _selectedImages) {
        var stream = http.ByteStream(File(image.path).openRead());
        var length = await File(image.path).length();
        var multipartFile = http.MultipartFile('images[]', stream, length,
            filename: image.name);
        request.files.add(multipartFile);
      }

      var response = await request.send();

      print('Create Product Response status: ${response.statusCode}');
      if (response.statusCode == 201) {
        print('Product created successfully');
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Product created successfully')));
      } else {
        var responseData = await response.stream.toBytes();
        var responseString = String.fromCharCodes(responseData);
        print('Failed to create product: $responseString');
        throw Exception('Failed to create product: $responseString');
      }
    } catch (e) {
      print('Failed to create product: $e');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create product: $e')));
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final product = Product(
        name: _name,
        price: _price,
        categoryId: _categoryId,
        description: _description,
        composision: _composision,
        images: _selectedImages.map((image) => image.path).toList(),
      );
      await _createProduct(product);
    }
  }

  Future<void> _pickImages() async {
    final List<XFile>? pickedImages = await _picker.pickMultiImage();
    if (pickedImages != null) {
      setState(() {
        _selectedImages = pickedImages;
      });
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
              margin: const EdgeInsets.only(left: 12, right: 12),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(16)),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_rounded),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            const Text(
              "Detail Produk",
              style: TextStyle(
                fontFamily: "Urbanist",
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 20),
              _buildImagePicker(),
              SizedBox(height: 10),
              _buildTextField(
                hint: 'Nama Kue',
                onSaved: (value) => _name = value!,
              ),
              SizedBox(height: 10),
              _buildTextField(
                hint: 'Harga',
                keyboardType: TextInputType.number,
                onSaved: (value) => _price = double.parse(value!),
              ),
              SizedBox(height: 10),
              _buildCategoryDropdown(),
              SizedBox(height: 10),
              _buildTextField(
                hint: 'Komposisi',
                onSaved: (value) => _composision = value!,
              ),
              SizedBox(height: 10),
              _buildTextField(
                hint: 'Deskripsi',
                maxLines: 3,
                onSaved: (value) => _description = value!,
              ),
              SizedBox(height: 160),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(
                  "Tambah produk",
                  style: TextStyle(
                    fontFamily: "Urbanist",
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 140),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    required FormFieldSetter<String> onSaved,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color.fromRGBO(232, 236, 244, 0)),
        ),
        hintText: hint,
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
      maxLines: maxLines,
      keyboardType: keyboardType,
      onSaved: onSaved,
    );
  }

  Widget _buildCategoryDropdown() {
    if (_categories.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return DropdownButtonFormField<int>(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color.fromRGBO(232, 236, 244, 0)),
          ),
          fillColor: Color.fromRGBO(247, 248, 249, 1),
          filled: true,
        ),
        hint: Text(
          'Pilih Kategori',
          style: TextStyle(
            color: Color.fromRGBO(131, 145, 161, 1),
            fontWeight: FontWeight.w500,
            fontFamily: "Urbanist",
          ),
        ),
        items: _categories.map((Category category) {
          return DropdownMenuItem<int>(
            value: category.id,
            child: Text(category.name),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _categoryId = value!;
          });
        },
        validator: (value) {
          if (value == null) return 'Please select a category';
          return null;
        },
      );
    }
  }

  Widget _buildImagePicker() {
    return Column(
      children: [
        OutlinedButton(
          onPressed: _pickImages,
          child: Text('Pilih Gambar'),
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 10,
          children: _selectedImages.map((image) {
            return Image.file(
              File(image.path),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            );
          }).toList(),
        ),
      ],
    );
  }
}
