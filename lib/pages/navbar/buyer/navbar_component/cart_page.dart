import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taartely_ui/model/cart.dart';
import 'package:taartely_ui/pages/buyer_component/create_order_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DuaPage extends StatefulWidget {
  const DuaPage({super.key});

  @override
  State<DuaPage> createState() => _DuaPageState();
}

class _DuaPageState extends State<DuaPage> {
  String baseUrl = dotenv.env["BASE_URL"] ?? "";
  List<CartItem> _cartItems = [];
  bool _isLoading = true;
  double _totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchCart();
  }

  Future<void> _fetchCart() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';

      final response = await http.get(
        Uri.parse('$baseUrl/carts'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var cartData = Cart.fromJson(json.decode(response.body));
        setState(() {
          _cartItems = cartData.items;
          _totalPrice = cartData.totalPrice.toDouble();
        });
      } else {
        throw Exception('Failed to load cart');
      }
    } catch (error) {
      print('Error fetching cart: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _addItemToCart(String productId, int quantity) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';

      final response = await http.post(
        Uri.parse('$baseUrl/carts'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'product_id': productId,
          'cart_detail_quantity': quantity,
        }),
      );

      if (response.statusCode == 200) {
        _fetchCart();
      } else {
        throw Exception('Failed to add item to cart');
      }
    } catch (error) {
      print('Error adding item to cart: $error');
    }
  }

  Future<void> _updateItemQuantity(String cartDetailId, int quantity) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';

      final response = await http.put(
        Uri.parse('$baseUrl/carts/$cartDetailId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'cart_detail_quantity': quantity,
        }),
      );

      if (response.statusCode == 200) {
        _fetchCart();
      } else {
        throw Exception('Failed to update item quantity');
      }
    } catch (error) {
      print('Error updating item quantity: $error');
    }
  }

  Future<void> _removeItemFromCart(String cartDetailId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';

      final response = await http.delete(
        Uri.parse('$baseUrl/carts/$cartDetailId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        _fetchCart();
      } else {
        throw Exception('Failed to remove item from cart');
      }
    } catch (error) {
      print('Error removing item from cart: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView(
                  padding: EdgeInsets.only(left: 32, right: 32, top: 20),
                  children: _cartItems.map((item) {
                    return ProductItem(
                      image: item.productImage ?? '',
                      name: item.productName,
                      rating: '4.5', // Set the rating manually
                      price: item.productPrice.toString(),
                      quantity: item.quantity,
                      onRemove: () => _removeItemFromCart(item.id.toString()),
                      onUpdateQuantity: (quantity) => _updateItemQuantity(item.id.toString(), quantity),
                    );
                  }).toList(),
                ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 32, right: 32, top: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Harga',
                        style: TextStyle(
                          fontFamily: "Urbanist",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "Rp." + _totalPrice.toString() + ",-",
                        style: TextStyle(
                          fontFamily: "Urbanist",
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return CreateOrderPage();
                      }));
                    },
                    child: Text(
                      "Pesan",
                      style: TextStyle(
                        fontFamily: "Urbanist",
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final String image;
  final String name;
  final String rating;
  final String price;
  final int quantity;
  final VoidCallback onRemove;
  final Function(int) onUpdateQuantity;

  const ProductItem({
    Key? key,
    required this.image,
    required this.name,
    required this.rating,
    required this.price,
    required this.quantity,
    required this.onRemove,
    required this.onUpdateQuantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final placeholderImage = 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png'; // URL gambar placeholder

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.network(
              image.isNotEmpty ? image : placeholderImage,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.network(
                  placeholderImage,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    fontFamily: "Urbanist",
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 11,
                      color: Colors.amber,
                    ),
                    SizedBox(width: 4),
                    Text(
                      rating,
                      style: TextStyle(
                        fontFamily: "Urbanist",
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      "(1045 Reviews)",
                      style: TextStyle(
                        fontFamily: "Urbanist",
                        fontWeight: FontWeight.w400,
                        fontSize: 11,
                        color: Color.fromRGBO(183, 183, 183, 1),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  "Rp." + price,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: "Urbanist",
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.delete_outline),
                onPressed: onRemove,
              ),
              CounterWidget(quantity: quantity, onUpdateQuantity: onUpdateQuantity),
              SizedBox(height: 4),
            ],
          ),
        ],
      ),
    );
  }
}

class CounterWidget extends StatelessWidget {
  final int quantity;
  final Function(int) onUpdateQuantity;

  const CounterWidget({
    Key? key,
    required this.quantity,
    required this.onUpdateQuantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.remove_circle_outline),
          onPressed: () {
            if (quantity > 1) {
              onUpdateQuantity(quantity - 1);
            }
          },
        ),
        Text(
          quantity.toString(),
          style: TextStyle(
            fontFamily: "Urbanist",
            fontSize: 14,
          ),
        ),
        IconButton(
          icon: Icon(Icons.add_circle_outline),
          onPressed: () {
            onUpdateQuantity(quantity + 1);
          },
        ),
      ],
    );
  }
}
