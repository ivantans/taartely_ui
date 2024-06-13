import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AddReviewPage extends StatefulWidget {
  final int orderId;
  final List<int> productIds;

  const AddReviewPage({Key? key, required this.orderId, required this.productIds}) : super(key: key);

  @override
  _AddReviewPageState createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  final Map<int, GlobalKey<FormState>> _formKeys = {};
  final Map<int, TextEditingController> _commentControllers = {};
  final Map<int, double> _ratingControllers = {};

  @override
  void initState() {
    super.initState();
    for (var productId in widget.productIds) {
      _formKeys[productId] = GlobalKey<FormState>();
      _commentControllers[productId] = TextEditingController();
      _ratingControllers[productId] = 0.0;
    }
  }

  @override
  void dispose() {
    for (var controller in _commentControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _submitReview(int productId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String baseUrl = dotenv.env["BASE_URL"] ?? "";

    final url = Uri.parse('$baseUrl/reviews/$productId/${widget.orderId}');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'product_review_comment': _commentControllers[productId]!.text,
        'product_review_rating': _ratingControllers[productId],
      }),
    );

    final responseData = json.decode(response.body);

    if (responseData['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(responseData['message'])));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(responseData['message'])));
    }
  }

  void _setRating(int productId, double rating) {
    setState(() {
      _ratingControllers[productId] = rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Review')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ...widget.productIds.map((productId) {
              return Form(
                key: _formKeys[productId],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Product ID: $productId', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextFormField(
                      controller: _commentControllers[productId],
                      decoration: InputDecoration(labelText: 'Comment'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a comment';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 8.0),
                    Text('Rating', style: TextStyle(fontWeight: FontWeight.bold)),
                    Row(
                      children: List.generate(5, (index) {
                        return IconButton(
                          icon: Icon(
                            index < _ratingControllers[productId]! ? Icons.star : Icons.star_border,
                          ),
                          color: Colors.amber,
                          onPressed: () => _setRating(productId, index + 1.0),
                        );
                      }),
                    ),
                    SizedBox(height: 8.0),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKeys[productId]!.currentState!.validate()) {
                        _submitReview(productId);
                        }
                      },
                      child: Text('Submit Review for Product $productId'),
                    ),
                    Divider(),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
