import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:taartely_ui/pages/admin_component/product/add_product_page.dart';
import 'package:taartely_ui/pages/admin_component/product/detail_product_page.dart'; // Import DetailProductPage
import 'package:taartely_ui/model/product_model.dart';

class ProductManagementPage extends StatefulWidget {
  const ProductManagementPage({super.key});

  @override
  State<ProductManagementPage> createState() => _ProductManagementPageState();
}

class _ProductManagementPageState extends State<ProductManagementPage> {
  String? _token;
  List<Category> categories = [];
  List<Product> products = [];
  bool isLoadingCategories = true;
  bool isLoadingProducts = true;
  int isSelected = 0;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('token');
    });
    fetchCategories();
    fetchProducts();
  }

  Future<void> fetchCategories() async {
    setState(() {
      isLoadingCategories = true;
    });
    String baseUrl = dotenv.env["BASE_URL"] ?? "";

    final response = await http.get(
      Uri.parse("$baseUrl/categories"),
      headers: {
        'Authorization': 'Bearer $_token',
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      setState(() {
        categories = jsonResponse
            .map((category) => Category.fromJson(category))
            .toList();
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
    String baseUrl = dotenv.env["BASE_URL"] ?? "";
    String url = category != null
        ? "$baseUrl/products?category=$category"
        : "$baseUrl/products";

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $_token',
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      setState(() {
        products =
            jsonResponse.map((product) => Product.fromJson(product)).toList();
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
      appBar: AppBar(
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
              "Kelola Produk",
              style: TextStyle(
                fontFamily: "Urbanist",
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 32, right: 32),
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
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
                      "Ada produk baru?",
                      style: TextStyle(
                          fontFamily: "Urbanist",
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                    Text(
                      "Perbarui produkmu!",
                      style: TextStyle(
                          fontFamily: "Urbanist",
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                          color: Colors.white),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return AddProductPage();
                            }));
                          },
                          child: Text(
                            " + Produk",
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
          SizedBox(
            height: 20,
          ),
          isLoadingCategories
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildProductCategory(index: 0, name: "All product"),
                      ...categories
                          .map((category) => _buildProductCategory(
                              index: category.id, name: category.category))
                          .toList(),
                    ],
                  ),
                ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Semua Produk",
            style: TextStyle(
              fontFamily: "Urbanist",
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          isLoadingProducts
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
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DetailProductPage(productId: product.id);
                        }));
                      },
                      child: _buildContainerProduct(
                          context: context,
                          image: product.images ??
                              'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg',
                          name: product.productName,
                          rating: product.averageRating.toString(),
                          price: product.productPrice.toString(),
                          review: product.reviewCount.toString(),
                          description: product.productDescription),
                    );
                  },
                ),
        ],
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

  _buildContainerProduct({
    required BuildContext context,
    required String image,
    required String name,
    required String rating,
    required String price,
    required String review,
    required String description,
  }) =>
      Container(
        height: 330,
        width: 180,
        decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(255, 0, 0, 0)),
            borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  image,
                  fit: BoxFit.fill,
                  height: 190,
                  width: 180,
                )),
            Container(
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                          fontFamily: "Urbanist",
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 12,
                          color: Colors.amber,
                        ),
                        Text(
                          rating,
                          style: TextStyle(
                              fontFamily: "Urbanist",
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                        Text(
                          " (" + review + " Reviews)",
                          style: TextStyle(
                              fontFamily: "Urbanist",
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Color.fromRGBO(183, 183, 183, 1)),
                        ),
                      ],
                    ),
                    Text(
                      "Rp." + price + ",-",
                      style: TextStyle(
                          fontFamily: "Urbanist",
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black),
                    )
                  ],
                )),
          ],
        ),
      );
}
