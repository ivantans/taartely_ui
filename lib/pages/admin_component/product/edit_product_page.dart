import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:taartely_ui/model/edit_product_model';

class EditProductPage extends StatefulWidget {
  final int productId;
  const EditProductPage({Key? key, required this.productId}) : super(key: key);

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  late Future<ProductDetail> product;
  List<Category> categories = [];
  String? selectedCategory;
  int? selectedStatus;
  String? baseUrl;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _compositionController = TextEditingController();
  final _descriptionController = TextEditingController();

  final List<Map<String, dynamic>> _statuses = [
    {'id': 1, 'status': 'available'},
    {'id': 2, 'status': 'empty'},
    {'id': 3, 'status': 'archive'},
    {'id': 4, 'status': 'deleted'},
  ];

  @override
  void initState() {
    super.initState();
    baseUrl = dotenv.env["BASE_URL"] ?? "";
    product = fetchProduct();
    fetchCategories();
  }

  Future<ProductDetail> fetchProduct() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse("$baseUrl/products/${widget.productId}"),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var productDetail = ProductDetail.fromJson(json.decode(response.body)['data']);
      _nameController.text = productDetail.productName;
      _priceController.text = productDetail.productPrice.toString();
      _compositionController.text = productDetail.productComposition;
      _descriptionController.text = productDetail.productDescription;
      selectedStatus = _statuses.firstWhere((status) => status['status'] == productDetail.productStatus)['id'];
      return productDetail;
    } else {
      throw Exception('Failed to load product');
    }
  }

  Future<void> fetchCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse("$baseUrl/categories"),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      setState(() {
        categories = jsonResponse.map((category) => Category.fromJson(category)).toList();
        product.then((productDetail) {
          selectedCategory = categories.firstWhere((category) => category.id == productDetail.categoryId).category;
        });
      });
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<void> updateProduct() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.put(
      Uri.parse("$baseUrl/products/${widget.productId}"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'product_name': _nameController.text,
        'product_price': double.parse(_priceController.text),
        'product_composision': _compositionController.text,
        'product_description': _descriptionController.text,
        'product_category_id': categories.firstWhere((category) => category.category == selectedCategory).id,
        'product_status_id': selectedStatus,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product updated successfully')),
      );
      Navigator.pop(context); // Kembali ke halaman sebelumnya setelah update
    } else {
      final errorResponse = jsonDecode(response.body);
      final errorMessage = errorResponse['message'];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update product: $errorMessage')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Produk"),
      ),
      body: FutureBuilder<ProductDetail>(
        future: product,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No product found'));
          } else {
            return Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: "Nama Produk"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter product name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _priceController,
                    decoration: const InputDecoration(labelText: "Harga Produk"),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter product price';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _compositionController,
                    decoration: const InputDecoration(labelText: "Komposisi Produk"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter product composition';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(labelText: "Deskripsi Produk"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter product description';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<int>(
                    decoration: const InputDecoration(labelText: "Status Produk"),
                    value: selectedStatus,
                    items: _statuses.map((status) {
                      return DropdownMenuItem<int>(
                        value: status['id'] as int,
                        child: Text(status['status'] as String),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedStatus = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select product status';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: "Kategori Produk"),
                    value: selectedCategory,
                    items: categories.map((category) {
                      return DropdownMenuItem<String>(
                        value: category.category,
                        child: Text(category.category),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select product category';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        updateProduct();
                      }
                    },
                    child: const Text("Update Produk"),
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
