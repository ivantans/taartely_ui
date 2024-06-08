import 'package:flutter/material.dart';
import 'package:taartely_ui/pages/navbar/buyer/buyer_navbar.dart';

class CreateOrderPage extends StatefulWidget {
  const CreateOrderPage({super.key});

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                "Pesan Kue",
                style: TextStyle(
                  fontFamily: "Urbanist",
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )
            ],
          ),
        ),
        body: Stack(
          children: [
            ListView(
              padding: EdgeInsets.only(left: 32, right: 32, top: 12),
              children: [
                Text(
                  "Detail Pesanan",
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Urbanist",
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(232, 236, 244, 0))),
                      hintText: "Nama Penerima",
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(131, 145, 161, 1),
                        fontWeight: FontWeight.w500,
                        fontFamily: "Urbanist",
                      ),
                      fillColor: Color.fromRGBO(247, 248, 249, 1),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromRGBO(232, 236, 244, 0)),
                        borderRadius: BorderRadius.circular(12),
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(232, 236, 244, 0))),
                      hintText: "No Telepon",
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(131, 145, 161, 1),
                        fontWeight: FontWeight.w500,
                        fontFamily: "Urbanist",
                      ),
                      fillColor: Color.fromRGBO(247, 248, 249, 1),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromRGBO(232, 236, 244, 0)),
                        borderRadius: BorderRadius.circular(12),
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(232, 236, 244, 0))),
                      hintText: "Tanggal Pengiriman",
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(131, 145, 161, 1),
                        fontWeight: FontWeight.w500,
                        fontFamily: "Urbanist",
                      ),
                      fillColor: Color.fromRGBO(247, 248, 249, 1),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromRGBO(232, 236, 244, 0)),
                        borderRadius: BorderRadius.circular(12),
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(232, 236, 244, 0))),
                      hintText: "Tambahkan Catatan Untuk Penjual",
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(131, 145, 161, 1),
                        fontWeight: FontWeight.w500,
                        fontFamily: "Urbanist",
                      ),
                      fillColor: Color.fromRGBO(247, 248, 249, 1),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromRGBO(232, 236, 244, 0)),
                        borderRadius: BorderRadius.circular(12),
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Daftar Produk",
                  style: TextStyle(
                    fontFamily: "Urbanist",
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
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
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: Colors.white,
                padding:
                    EdgeInsets.only(left: 32, right: 32, top: 20, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Pesanan (7 produk):',
                          style: TextStyle(
                            fontFamily: "Urbanist",
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Rp." + "200000" + ",-",
                          style: TextStyle(
                              fontFamily: "Urbanist",
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 15),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return HomePage();
                          }));
                        },
                        child: Text(
                          "Buat Pesanan",
                          style: TextStyle(
                              fontFamily: "Urbanist",
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: EdgeInsets.only(
                                left: 150, right: 150, top: 20, bottom: 20)),
                      ),
                    ),
                  ],
                ),
              ),
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
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
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
        ],
      ),
    );
  }
}
