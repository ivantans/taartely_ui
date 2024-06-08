import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taartely_ui/model/productDetail.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DetailProductPage extends StatefulWidget {
  final int productId;
  const DetailProductPage({Key? key, required this.productId})
      : super(key: key);

  @override
  _DetailProductPageState createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  late Future<ProductDetail> product;
  int _quantity = 1;
  String baseUrl = dotenv.env["BASE_URL"] ?? "";

  Future<ProductDetail> fetchProduct() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    

    final response = await http.get(
      Uri.parse(
          "$baseUrl/products/${widget.productId}"),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return ProductDetail.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Failed to load product');
    }
  }

  Future<void> addToCart(int productId, int quantity) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.post(
      Uri.parse("$baseUrl/carts"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'product_id': productId,
        'cart_detail_quantity': quantity,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product added to cart successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add product to cart')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    product = fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
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
              final product = snapshot.data!;
              return Stack(
                children: [
                  ListView(
                    children: [
                      Center(
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 32, right: 32, top: 32),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: product.images != null
                                ? Image.network(product.images!,
                                    fit: BoxFit.cover)
                                : Image.asset('images/cup.jpg',
                                    fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      Container(
                        padding:
                            const EdgeInsets.only(left: 32, right: 32, top: 12),
                        child: Text(
                          product.productName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            fontFamily: "Urbanist",
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 32, right: 32),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 14,
                                  color: Colors.amber,
                                ),
                                const Text(
                                  '4.5', // This should come from the product data if available
                                  style: TextStyle(
                                    fontFamily: "Urbanist",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                const Text(
                                  " (1045 Reviews)",
                                  style: TextStyle(
                                    fontFamily: "Urbanist",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Color.fromRGBO(183, 183, 183, 1),
                                  ),
                                ),
                              ],
                            ),
                            CounterWidget(
                              onQuantityChanged: (quantity) {
                                setState(() {
                                  _quantity = quantity;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 32, right: 32),
                        child: const Text(
                          "Tentang Produk",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "Urbanist",
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Container(
                        padding:
                            const EdgeInsets.only(left: 32, right: 32, top: 10),
                        child: Text(
                          product.productDescription,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: "Urbanist",
                            fontSize: 14,
                            color: Color.fromRGBO(127, 127, 127, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(
                          left: 32, right: 32, top: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Harga',
                                style: TextStyle(
                                  fontFamily: "Urbanist",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "Rp.${product.productPrice},-",
                                style: const TextStyle(
                                  fontFamily: "Urbanist",
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              await addToCart(widget.productId, _quantity);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text('Product berhasil ditambahkan')),
                              );
                            },
                            child: const Text(
                              "Masukkan Keranjang",
                              style: TextStyle(
                                fontFamily: "Urbanist",
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              padding: const EdgeInsets.only(
                                  left: 50, right: 50, top: 20, bottom: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class CounterWidget extends StatefulWidget {
  final Function(int) onQuantityChanged;
  const CounterWidget({Key? key, required this.onQuantityChanged})
      : super(key: key);

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 1;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    widget.onQuantityChanged(_counter);
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
    widget.onQuantityChanged(_counter);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5.0,
            spreadRadius: 1.0,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: _decrementCounter,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(5), // Text Color
              minimumSize: const Size(20, 20), // Ukuran minimal tombol
            ),
            child: const Icon(Icons.remove,
                color: Colors.black, size: 12), // Mengurangi ukuran ikon
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 10.0), // Mengurangi padding di sekitar teks
            child: Text(
              '$_counter',
              style: const TextStyle(fontSize: 12), // Mengurangi ukuran teks
            ),
          ),
          ElevatedButton(
            onPressed: _incrementCounter,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.black,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(5), // Text Color
              minimumSize: const Size(20, 20), // Ukuran minimal tombol
            ),
            child: const Icon(Icons.add, size: 12), // Mengurangi ukuran ikon
          ),
        ],
      ),
    );
  }
}
