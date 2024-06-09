import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DetailOrderPage extends StatefulWidget {
  final int orderId;

  const DetailOrderPage({Key? key, required this.orderId}) : super(key: key);

  @override
  _DetailOrderPageState createState() => _DetailOrderPageState();
}

class _DetailOrderPageState extends State<DetailOrderPage> {
  late Future<OrderDetail> orderDetail;
  String baseUrl = dotenv.env["BASE_URL"] ?? "";

  @override
  void initState() {
    super.initState();
    orderDetail = fetchOrderDetail();
  }

  Future<OrderDetail> fetchOrderDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('$baseUrl/orders/${widget.orderId}'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return OrderDetail.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Failed to load order detail');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Detail'),
      ),
      body: FutureBuilder<OrderDetail>(
        future: orderDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No order detail found'));
          } else {
            final orderDetail = snapshot.data!;
            return ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                Text('Order ID: ${orderDetail.orderId}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('Status: ${orderDetail.orderStatusName}', style: TextStyle(fontSize: 16)),
                Text('Buyer Name: ${orderDetail.buyerName}', style: TextStyle(fontSize: 16)),
                Text('Address: ${orderDetail.userAddress}', style: TextStyle(fontSize: 16)),
                Text('Phone Number: ${orderDetail.userPhoneNumber}', style: TextStyle(fontSize: 16)),
                SizedBox(height: 16.0),
                Text('Order Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ...orderDetail.orderDetails.map((detail) {
                  return ListTile(
                    title: Text(detail.productName),
                    subtitle: Text('Quantity: ${detail.orderDetailQuantity}'),
                  );
                }).toList(),
              ],
            );
          }
        },
      ),
    );
  }
}

class OrderDetail {
  final int orderId;
  final String orderStatusName;
  final String buyerName;
  final String userAddress;
  final String userPhoneNumber;
  final List<OrderDetailItem> orderDetails;

  OrderDetail({
    required this.orderId,
    required this.orderStatusName,
    required this.buyerName,
    required this.userAddress,
    required this.userPhoneNumber,
    required this.orderDetails,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    var list = json['order_details'] as List;
    List<OrderDetailItem> orderDetailsList = list.map((i) => OrderDetailItem.fromJson(i)).toList();

    return OrderDetail(
      orderId: json['order_id'],
      orderStatusName: json['order_status_name'],
      buyerName: json['buyer_name'],
      userAddress: json['user_address'],
      userPhoneNumber: json['user_phone_number'],
      orderDetails: orderDetailsList,
    );
  }
}

class OrderDetailItem {
  final String productName;
  final int orderDetailQuantity;

  OrderDetailItem({
    required this.productName,
    required this.orderDetailQuantity,
  });

  factory OrderDetailItem.fromJson(Map<String, dynamic> json) {
    return OrderDetailItem(
      productName: json['product_name'],
      orderDetailQuantity: json['order_detail_quantity'],
    );
  }
}
