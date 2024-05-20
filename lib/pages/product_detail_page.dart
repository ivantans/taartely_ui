import 'package:flutter/material.dart';

class DetailProductPage extends StatelessWidget {
  final String image;
  final String name;
  final String rating;
  final String price;
  final String description;
  const DetailProductPage(
      {Key? key,
      required this.image,
      required this.name,
      required this.rating,
      required this.description,
      required this.price})
      : super(key: key);

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
                "Detail Produk",
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
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.only(left: 32, right: 32, top: 32),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(image),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 32, right: 32, top: 12),
                  child: Text(
                    name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        fontFamily: "Urbanist"),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 32, right: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 14,
                            color: Colors.amber,
                          ),
                          Text(
                            rating,
                            style: TextStyle(
                                fontFamily: "Urbanist",
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          Text(
                            " (1045 Reviews)",
                            style: TextStyle(
                                fontFamily: "Urbanist",
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Color.fromRGBO(183, 183, 183, 1)),
                          ),
                        ],
                      ),
                      CounterWidget()
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 32, right: 32),
                  child: Text(
                    "Tentang Produk",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "Urbanist",
                      fontSize: 14,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 32, right: 32, top: 10),
                  child: Text(
                    description,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: "Urbanist",
                        fontSize: 14,
                        color: Color.fromRGBO(127, 127, 127, 1)),
                  ),
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
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "Rp." + price + ",-",
                          style: TextStyle(
                              fontFamily: "Urbanist",
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Masukkan Keranjang",
                        style: TextStyle(
                          fontFamily: "Urbanist",
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 20)
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

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 1;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5.0,
            spreadRadius: 1.0,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: _decrementCounter,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black, backgroundColor: Colors.white,
              shape: CircleBorder(),
              padding: EdgeInsets.all(5), // Text Color
              minimumSize: Size(20, 20), // Ukuran minimal tombol
            ),
            child: Icon(Icons.remove,
                color: Colors.black, size: 12), // Mengurangi ukuran ikon
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 10.0), // Mengurangi padding di sekitar teks
            child: Text(
              '$_counter',
              style: TextStyle(fontSize: 12), // Mengurangi ukuran teks
            ),
          ),
          ElevatedButton(
            onPressed: _incrementCounter,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Colors.black,
              shape: CircleBorder(),
              padding: EdgeInsets.all(5), // Text Color
              minimumSize: Size(20, 20), // Ukuran minimal tombol
            ),
            child: Icon(Icons.add, size: 12), // Mengurangi ukuran ikon
          ),
        ],
      ),
    );
  }
}
