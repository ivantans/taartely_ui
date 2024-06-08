import 'package:flutter/material.dart';
import 'package:taartely_ui/pages/admin_component/detail_order_page.dart';

class DuaPage extends StatefulWidget {
  const DuaPage({super.key});

  @override
  State<DuaPage> createState() => _DuaPageState();
}

class _DuaPageState extends State<DuaPage> {
  int isSelected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: EdgeInsets.only(left: 12),
          child: Text(
            "Kelola Pesanan",
            style: TextStyle(
                fontFamily: "Urbanist",
                fontWeight: FontWeight.bold,
                fontSize: 30),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
        children: [
          SizedBox(
            height: 50, // Atur tinggi sesuai kebutuhan
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildProductCategory(index: 0, name: "Semua"),
                _buildProductCategory(index: 1, name: "Menunggu"),
                _buildProductCategory(index: 2, name: "Belum Bayar"),
                _buildProductCategory(index: 3, name: "Proses"),
              ],
            ),
          ),
          SizedBox(
            height: 24,
          ),
          OrderItem(
            status: 'Menunggu',
            products: [
              ProductItem(
                image: 'images/cup.jpg',
                name: 'Kue Berwarna Coklat Muda',
                rating: '4.5',
                price: 'RP. 150.000,-',
                quantity: 1,
              ),
              ProductItem(
                image: 'images/cup.jpg',
                name: '1 Box Cupcake Buah-Buahan',
                rating: '4.5',
                price: 'RP. 90.000,-',
                quantity: 1,
              ),
              ProductItem(
                image: 'images/cup.jpg',
                name: 'Sando Munch',
                rating: '4.5',
                price: 'RP. 20.000,-',
                quantity: 5,
              ),
            ],
            totalPrice: 'RP. 340.000,-',
          ),
          OrderItem(
            status: 'Menunggu',
            products: [
              ProductItem(
                image: 'images/cup.jpg',
                name: 'Sando Munch',
                rating: '4.5',
                price: 'RP. 20.000,-',
                quantity: 10,
              ),
            ],
            totalPrice: 'RP. 200.000,-',
          ),
        ],
      ),
    );
  }

  _buildProductCategory({required int index, required String name}) =>
      Container(
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
      );
}

class OrderItem extends StatelessWidget {
  final String status;
  final List<ProductItem> products;
  final String totalPrice;

  const OrderItem({
    Key? key,
    required this.status,
    required this.products,
    required this.totalPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DetailOrderPage();
        }));
      },
      child: Container(
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
                Text(status, style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 8.0),
            Column(children: products),
            SizedBox(height: 8.0),
            Text('Total', style: TextStyle(fontSize: 14, color: Colors.grey)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(totalPrice,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Konfirmasi"),
                              content: Text("Yakin ingin diterima?"),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 12.0),
                      child: Text("Terima",
                          style: TextStyle(fontSize: 12, color: Colors.white)),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Konfirmasi"),
                              content: Text("Yakin ingin ditolak?"),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 12.0),
                      child: Text("Tolak",
                          style: TextStyle(fontSize: 12, color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
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

  const ProductItem({
    Key? key,
    required this.image,
    required this.name,
    required this.rating,
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
            child: Image.asset(
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
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 16,
                      color: Colors.amber,
                    ),
                    SizedBox(width: 4),
                    Text(
                      rating,
                      style: TextStyle(
                        fontFamily: "Urbanist",
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      "(1045 Reviews)",
                      style: TextStyle(
                        fontFamily: "Urbanist",
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color.fromRGBO(183, 183, 183, 1),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  price,
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
