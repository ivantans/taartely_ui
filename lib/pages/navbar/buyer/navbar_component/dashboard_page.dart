import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:taartely_ui/model/product_model.dart';
import 'package:taartely_ui/pages/buyer_component/product/all_product_page.dart';
import 'package:taartely_ui/pages/buyer_component/product/product_detail_page.dart';

class SatuPage extends StatefulWidget {
  const SatuPage({super.key});

  @override
  State<SatuPage> createState() => _SatuPageState();
}

class _SatuPageState extends State<SatuPage> {
  int isSelected = 0;
  List<Category> categories = [];
  List<Product> products = [];
  bool isLoadingCategories = true;
  bool isLoadingProducts = true;

  @override
  void initState() {
    super.initState();
    fetchCategories();
    fetchProducts();
  }

  Future<void> fetchCategories() async {
    setState(() {
      isLoadingCategories = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String baseUrl = dotenv.env["BASE_URL"] ?? "";

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
        isLoadingCategories = false;
      });
    } else {
      setState(() {
        isLoadingCategories = false;
      });
      throw Exception('Failed to load categories');
    }
  }

  Future<void> fetchProducts([String? category]) async {
    setState(() {
      isLoadingProducts = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String baseUrl = dotenv.env["BASE_URL"] ?? "";
    String url = category != null ? "$baseUrl/products?category=$category" : "$baseUrl/products";

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      setState(() {
        products = jsonResponse.map((product) => Product.fromJson(product)).toList();
        isLoadingProducts = false;
      });
    } else {
      setState(() {
        isLoadingProducts = false;
      });
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 32, right: 32, top: 18),
              padding: EdgeInsets.all(22),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: Color.fromRGBO(158, 21, 69, 1)),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Kereasikan Kuemu!!",
                        style: TextStyle(
                            fontFamily: "Urbanist",
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                      Text(
                        "Kini kamu bisa membuat kue impianmu di Taartely",
                        style: TextStyle(
                            fontFamily: "Urbanist",
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Colors.white),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              "custom kue",
                              style: TextStyle(
                                  fontFamily: "Urbanist",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black),
                            )),
                      )
                    ],
                  ),
                  Column(
                      // children: [Image.asset("name")],
                      ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 14,
                left: 32,
              ),
              child: isLoadingCategories
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildProductCategory(index: 0, name: "All product"),
                          ...categories.map((category) => _buildProductCategory(index: category.id, name: category.category)).toList(),
                        ],
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 32, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Katalog Produk",
                    style: TextStyle(
                        fontFamily: "Urbanist",
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color.fromRGBO(30, 35, 44, 1)),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return AllProductPage();
                      }));
                    },
                    child: Text(
                      "Lihat semua",
                      style: TextStyle(
                          fontFamily: "Urbanist",
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              child: isLoadingProducts
                  ? Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.65,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return ProductCard(product: product);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  _buildProductCategory({required int index, required String name}) =>
      GestureDetector(
        onTap: () {
          setState(() {
            isSelected = index;
          });
          fetchProducts(index == 0 ? null : name); // Fetch products by category
        },
        child: Container(
          width: 100,
          height: 40,
          margin: const EdgeInsets.only(top: 10, right: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: isSelected == index
                  ? Color.fromRGBO(158, 21, 69, 1)
                  : Color.fromRGBO(255, 255, 255, 1),
              border: isSelected == index
                  ? Border.all(width: 0)
                  : Border.all(color: Color.fromRGBO(232, 236, 244, 1)),
              borderRadius: BorderRadius.circular(16)),
          child: Text(
            name,
            style: TextStyle(
                color: isSelected == index
                    ? Colors.white
                    : Color.fromRGBO(63, 63, 63, 1),
                fontFamily: "Urbanist"),
          ),
        ),
      );
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
