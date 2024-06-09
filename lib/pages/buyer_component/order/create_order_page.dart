import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:taartely_ui/model/cart.dart';  // Import model Cart dan CartItem
import 'package:intl/intl.dart';
import 'package:taartely_ui/model/contact_model.dart';  // Import untuk pemformatan tanggal

class CreateOrderPage extends StatefulWidget {
  const CreateOrderPage({super.key});

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  String baseUrl = dotenv.env["BASE_URL"] ?? "";
  late Future<Cart> _cartFuture;
  late Future<List<Contact>> _contactsFuture;
  final _formKey = GlobalKey<FormState>();
  String _notes = '';
  DateTime? _orderDueDate;
  int? _selectedContactId;

  @override
  void initState() {
    super.initState();
    _cartFuture = _loadCart();
    _contactsFuture = _loadContacts();
  }

  Future<Cart> _loadCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final url = Uri.parse('$baseUrl/carts');
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Cart.fromJson(data);
      } else {
        throw Exception('Failed to load cart: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Failed to load cart: $e');
      throw Exception('Failed to load cart');
    }
  }

  Future<List<Contact>> _loadContacts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final url = Uri.parse('$baseUrl/contacts');
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        return data.map((json) => Contact.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load contacts: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Failed to load contacts: $e');
      throw Exception('Failed to load contacts');
    }
  }

  Future<void> _createOrder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final url = Uri.parse('$baseUrl/orders');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'order_note': _notes,
          'order_due_date': _orderDueDate != null ? DateFormat('yyyy-MM-dd').format(_orderDueDate!) : null,
          'user_contact_id': _selectedContactId,
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Order created successfully'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
        Navigator.pop(context);
      } else {
        var responseData = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to create order: ${responseData['message']}'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print('Failed to create order: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to create order: $e'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _selectDueDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _orderDueDate) {
      setState(() {
        _orderDueDate = pickedDate;
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await _createOrder();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 12, right: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(16),
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Text(
              "Pesan Kue",
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
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Tambahkan Catatan Untuk Penjual'),
                onSaved: (value) => _notes = value!,
              ),
              InkWell(
                onTap: () => _selectDueDate(context),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Tanggal Pengiriman (DD-MM-YYYY)',
                  ),
                  child: Text(
                    _orderDueDate == null
                        ? 'Pilih Tanggal'
                        : DateFormat('dd-MM-yyyy').format(_orderDueDate!),
                  ),
                ),
              ),
              FutureBuilder<List<Contact>>(
                future: _contactsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Failed to load contacts'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No contacts found'));
                  } else {
                    return DropdownButtonFormField<int>(
                      decoration: InputDecoration(labelText: 'Select Contact'),
                      items: snapshot.data!.map((Contact contact) {
                        return DropdownMenuItem<int>(
                          value: contact.id,
                          child: Text('${contact.name} - ${contact.userAddress} - ${contact.userPhoneNumber}'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        _selectedContactId = value!;
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a contact';
                        }
                        return null;
                      },
                    );
                  }
                },
              ),
              SizedBox(height: 20),
              Expanded(
                child: FutureBuilder<Cart>(
                  future: _cartFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Failed to load cart'));
                    } else if (!snapshot.hasData || snapshot.data!.items.isEmpty) {
                      return Center(child: Text('No products in cart'));
                    } else {
                      return Column(
                        children: [
                          Text(
                            'Total Produk: ${snapshot.data!.totalProduct}',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Total Kuantitas: ${snapshot.data!.totalQuantity}',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Total Harga: Rp. ${snapshot.data!.totalPrice}',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: snapshot.data!.items.length,
                              itemBuilder: (context, index) {
                                var product = snapshot.data!.items[index];
                                return ListTile(
                                  title: Text(product.productName),
                                  subtitle: Text('Price: ${product.productPrice} - Quantity: ${product.quantity}'),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Buat Pesanan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

