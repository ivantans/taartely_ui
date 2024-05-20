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
                  padding: EdgeInsets.only(left: 32, right: 32, top: 8, bottom: 10),
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
                      // CounterWidget()
                      Text("Lihat penulaian", style: TextStyle(
                        fontFamily: "Urbanist",
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        decoration: TextDecoration.underline
                      ), 
                      )
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
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Edit",
                        style: TextStyle(
                          fontFamily: "Urbanist",
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 10)
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Hapus",
                        style: TextStyle(
                          fontFamily: "Urbanist",
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 10)
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Tampilkan",
                        style: TextStyle(
                          fontFamily: "Urbanist",
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 10)
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