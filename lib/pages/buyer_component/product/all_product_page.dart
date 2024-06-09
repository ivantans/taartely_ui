import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taartely_ui/model/product_model.dart';
import 'product_detail_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AllProductPage extends StatelessWidget {
  const AllProductPage({super.key});

  Future<List<Product>> fetchProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String baseUrl = dotenv.env["BASE_URL"] ?? "";

    final response = await http.get(
      Uri.parse("$baseUrl/products"),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      ProductResponse productResponse = ProductResponse.fromJson(jsonResponse);
      return productResponse.data;
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Container(
            margin: const EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(16),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        body: FutureBuilder<List<Product>>(
          future: fetchProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No products found'));
            } else {
              return ListView(
                children: [
                  const Center(
                    child: Text(
                      "Semua Produk",
                      style: TextStyle(
                        fontFamily: "Urbanist",
                        fontWeight: FontWeight.w800,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  const Divider(
                    height: 50,
                    color: Colors.black,
                    thickness: 3,
                    indent: 150,
                    endIndent: 150,
                  ),
                  const Center(
                    child: SizedBox(
                      width: 300,
                      child: Column(
                        children: [
                          Text(
                            "Temukan kuemu di sini",
                            style: TextStyle(
                              fontFamily: "Urbanist",
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Color.fromRGBO(127, 127, 127, 1),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "Rasakan kenyamanan dan kebahagiaan dengan sepotong makanan manis hanya dari Taartely, buat kamu, ",
                            style: TextStyle(
                              fontFamily: "Urbanist",
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Color.fromRGBO(127, 127, 127, 1),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 20),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.65,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final product = snapshot.data![index];
                        return ProductCard(product: product);
                      },
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

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DetailProductPage(productId: product.id);
        }));
      },
      child: Container(
        height: 280,
        width: 180,
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromRGBO(255, 0, 0, 0)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: product.images != null
                  ? Image.network(
                      product.images!,
                      fit: BoxFit.fill,
                      height: 190,
                      width: 180,
                    )
                  : Image.asset(
                      'images/cup.jpg',
                      fit: BoxFit.fill,
                      height: 190,
                      width: 180,
                    ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.productName,
                    style: const TextStyle(
                      fontFamily: "Urbanist",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 12,
                        color: Colors.amber,
                      ),
                      Text(
                        product.averageRating
                            .toString(), // Use actual rating from API
                        style: const TextStyle(
                          fontFamily: "Urbanist",
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        " (${product.reviewCount} Reviews)", // Use actual review count from API
                        style: const TextStyle(
                          fontFamily: "Urbanist",
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Color.fromRGBO(183, 183, 183, 1),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Rp.${product.productPrice},-",
                    style: const TextStyle(
                      fontFamily: "Urbanis",
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
