import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:taartely_ui/model/product_detail_model.dart';
import 'package:taartely_ui/pages/buyer_component/review/review_page.dart';
import 'package:taartely_ui/pages/admin_component/product/edit_product_page.dart';

class DetailProductPage extends StatefulWidget {
  final int productId;
  const DetailProductPage({Key? key, required this.productId}) : super(key: key);

  @override
  _DetailProductPageState createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  late Future<ProductDetail> product;
  String baseUrl = dotenv.env["BASE_URL"] ?? "";

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
      return ProductDetail.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Failed to load product');
    }
  }

  Future<void> deleteProduct(int productId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.delete(
      Uri.parse("$baseUrl/products/$productId"),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product deleted successfully')),
      );
      Navigator.pop(context); // Kembali ke halaman sebelumnya setelah penghapusan
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete product')),
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, 
        title: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 12, right: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(16),
              ),
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
            ),
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
                        padding: const EdgeInsets.only(left: 32, right: 32, top: 32),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: product.images != null
                              ? Image.network(product.images!, fit: BoxFit.cover)
                              : Image.asset('images/cup.jpg', fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 32, right: 32, top: 12),
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
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReviewPage(productId: widget.productId),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.star, size: 14, color: Colors.amber),
                                Text(
                                  '${product.averageRating}',
                                  style: const TextStyle(
                                    fontFamily: "Urbanist",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  " (${product.reviewCount} Reviews)",
                                  style: const TextStyle(
                                    fontFamily: "Urbanist",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Color.fromRGBO(183, 183, 183, 1),
                                  ),
                                ),
                              ],
                            ),
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
                      padding: const EdgeInsets.only(left: 32, right: 32, top: 10),
                      child: Text(
                        product.productComposition,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: "Urbanist",
                          fontSize: 14,
                          color: Color.fromRGBO(127, 127, 127, 1),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 32, right: 32, top: 10),
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
                    Container(
                      padding: const EdgeInsets.only(left: 32, right: 32, top: 10),
                      child: Text(
                        "Harga: Rp. ${product.productPrice},-",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Urbanist",
                          fontSize: 18,
                          color: Colors.black,
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
                    padding: const EdgeInsets.only(left: 32, right: 32, top: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProductPage(productId: widget.productId),
                              ),
                            );
                          },
                          child: const Text(
                            "Edit Produk",
                            style: TextStyle(
                              fontFamily: "Urbanist",
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await deleteProduct(widget.productId);
                          },
                          child: const Text(
                            "Hapus Produk",
                            style: TextStyle(
                              fontFamily: "Urbanist",
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
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
    );
  }
}
