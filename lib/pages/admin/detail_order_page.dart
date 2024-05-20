import 'package:flutter/material.dart';

class DetailOrderPage extends StatelessWidget {
  const DetailOrderPage({super.key});

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
                "Detail Pesanan",
                style: TextStyle(
                  fontFamily: "Urbanist",
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        body: Stack(children: [
          ListView(
            padding: EdgeInsets.only(bottom: 32, left: 32, right: 20),
            children: [
              SizedBox(height: 20,),
              Text(
                "Detail Pesanan",
                style: TextStyle(
                  fontFamily: "Urbanist",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Color.fromRGBO(232, 236, 244, 1)),
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromRGBO(247, 248, 249, 1)),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Susi Susanti ",
                      style: TextStyle(
                        fontFamily: "Urbanist",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "081234567890",
                      style: TextStyle(
                        fontFamily: "Urbanist",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "17 Agustus 2024",
                      style: TextStyle(
                        fontFamily: "Urbanist",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "SSaya ingin pesanan dikirim jam 7 pagi",
                      style: TextStyle(
                        fontFamily: "Urbanist",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Daftar Produk",
                style: TextStyle(
                  fontFamily: "Urbanist",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Rp. 340.000,-",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () {},
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
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white)),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () {},
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
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        ]),
      ),
    );
  }
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Status:', style: TextStyle(fontWeight: FontWeight.w400, fontFamily: "Urbanist")),
                Text(status, style: TextStyle(fontWeight: FontWeight.w400, fontFamily: "Urbanist")),
              ],
            ),
            SizedBox(height: 8.0),
            Column(children: products),
            SizedBox(height: 8.0),
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
