import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taartely_ui/model/order.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:taartely_ui/pages/admin_component/order/order_detail_page.dart';
import 'package:taartely_ui/pages/buyer_component/review/add_review.dart';
import 'package:url_launcher/url_launcher.dart';

class DuaPage extends StatefulWidget {
  const DuaPage({super.key});

  @override
  State<DuaPage> createState() => _DuaPageState();
}

class _DuaPageState extends State<DuaPage> {
  String baseUrl = dotenv.env["BASE_URL"] ?? "";
  late Future<List<Order>> _ordersFuture;
  int isSelected = 0;

  @override
  void initState() {
    super.initState();
    _ordersFuture = _loadOrders();
  }

  Future<List<Order>> _loadOrders({String? status}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final url = Uri.parse('$baseUrl/orders${status != null ? '?status=$status' : ''}');
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        return data.map((json) => Order.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load orders: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Failed to load orders: $e');
      throw Exception('Failed to load orders');
    }
  }

  Future<void> _approveOrder(int orderId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final url = Uri.parse('$baseUrl/orders/approve/$orderId');
    try {
      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Order approved successfully')));
        setState(() {
          _ordersFuture = _loadOrders();
        });
      } else {
        throw Exception('Failed to approve order: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Failed to approve order: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to approve order')));
    }
  }

  Future<void> _cancelOrder(int orderId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final url = Uri.parse('$baseUrl/orders/cancel/$orderId');
    try {
      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Order cancelled successfully')));
        setState(() {
          _ordersFuture = _loadOrders();
        });
      } else {
        throw Exception('Failed to cancel order: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Failed to cancel order: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to cancel order')));
    }
  }

  Future<void> _completeOrder(int orderId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final url = Uri.parse('$baseUrl/orders/complete/$orderId');
    try {
      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Order completed successfully')));
        setState(() {
          _ordersFuture = _loadOrders();
        });
      } else {
        throw Exception('Failed to complete order: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Failed to complete order: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to complete order')));
    }
  }

  Future<void> _addReview(int orderId, List<int> productIds) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddReviewPage(orderId: orderId, productIds: productIds)),
    );
  }

  Future<void> _viewOrderDetails(int orderId) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailOrderPage(orderId: orderId)),
    );
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
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildProductCategory(index: 0, name: "Semua", status: null),
                _buildProductCategory(index: 1, name: "Menunggu", status: '1'),
                _buildProductCategory(index: 2, name: "Belum Bayar", status: '2'),
                _buildProductCategory(index: 3, name: "Proses", status: '3'),
                _buildProductCategory(index: 4, name: "Selesai", status: '4'),
                _buildProductCategory(index: 5, name: "Dibatalkan pembeli", status: '5'),
                _buildProductCategory(index: 6, name: "Dibatalkan penjual", status: '6'),
                _buildProductCategory(index: 7, name: "Expire", status: '7'),
              ],
            ),
          ),
          SizedBox(height: 24),
          FutureBuilder<List<Order>>(
            future: _ordersFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Failed to load orders'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No orders found'));
              } else {
                return Column(
                  children: snapshot.data!.map((order) => OrderItem(
                    order: order,
                    onApprove: _approveOrder,
                    onCancel: _cancelOrder,
                    onComplete: _completeOrder,
                    onAddReview: _addReview,
                    onViewDetails: _viewOrderDetails,
                  )).toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProductCategory({required int index, required String name, String? status}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = index;
          _ordersFuture = _loadOrders(status: status);
        });
      },
      child: Container(
        width: 100,
        height: 40,
        margin: const EdgeInsets.only(right: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected == index
              ? Color.fromRGBO(158, 21, 69, 1)
              : Color.fromRGBO(255, 255, 255, 1),
          border: isSelected == index
              ? Border.all(width: 0)
              : Border.all(color: Color.fromRGBO(232, 236, 244, 1)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          name,
          style: TextStyle(
            color: isSelected == index ? Colors.white : Color.fromRGBO(63, 63, 63, 1),
            fontFamily: "Urbanist",
          ),
        ),
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  final Order order;
  final Function(int) onApprove;
  final Function(int) onCancel;
  final Function(int) onComplete;
  final Function(int, List<int>) onAddReview;
  final Function(int) onViewDetails;

  const OrderItem({Key? key, required this.order, required this.onApprove, required this.onCancel, required this.onComplete, required this.onAddReview, required this.onViewDetails}) : super(key: key);

  void _launchURL(String url) async {
    final encodedUrl = Uri.encodeFull(url);
    print("Attempting to launch URL: $encodedUrl");
    if (await canLaunch(encodedUrl)) {
      await launch(encodedUrl);
    } else {
      print('Could not launch $encodedUrl');
      throw 'Could not launch $encodedUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Status:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(order.orderStatusName, style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 8.0),
          Column(
            children: order.orderDetails.map((detail) {
              return ProductItem(
                image: detail.productImage ?? 'https://via.placeholder.com/80',
                name: detail.productName,
                price: detail.productPrice.toString(),
                quantity: detail.quantity,
              );
            }).toList(),
          ),
          SizedBox(height: 8.0),
          Text('Total', style: TextStyle(fontSize: 14, color: Colors.grey)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'RP. ${order.orderTotalPrice},-',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Align(
                child: _buildActionButtons(context),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          ElevatedButton(
            onPressed: () => onViewDetails(order.id),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              child: Text(
                'View Details',
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    final orderStatus = order.orderStatusName.toLowerCase();
    if (orderStatus == 'pending') {
      return Row(
        children: [
          ElevatedButton(
            onPressed: () => onApprove(order.id),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              child: Text(
                'Accept',
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
          ),
          SizedBox(width: 8),
          ElevatedButton(
            onPressed: () => onCancel(order.id),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              child: Text(
                'Cancel',
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
          ),
        ],
      );
    } else if (orderStatus == 'accepted') {
      return ElevatedButton(
        onPressed: () => onCancel(order.id),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
          child: Text(
            'Cancel',
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
        ),
      );
    } else if (orderStatus == 'process') {
      return ElevatedButton(
        onPressed: () => onComplete(order.id),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
          child: Text(
            'Complete',
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}

class ProductItem extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final int quantity;

  const ProductItem({
    Key? key,
    required this.image,
    required this.name,
    required this.price,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.network(
              image,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
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
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: "Urbanist",
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'RP. $price,-',
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
          Container(
            padding: EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Text(
              'x$quantity',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
