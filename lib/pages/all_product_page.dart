import 'package:flutter/material.dart';
import 'package:taartely_ui/pages/product_detail_page.dart';

class AllProductPage extends StatelessWidget {
  const AllProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Container(
            margin: EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(16)),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        body: ListView(
          children: [
            Center(
              child: Text(
                "Semua Produk",
                style: TextStyle(
                  fontFamily: "Urbanist",
                  fontWeight: FontWeight.w800,
                  fontSize: 30,
                ),
              ),
            ),
            Divider(
              height: 50,
              color: Colors.black,
              thickness: 3,
              indent: 150,
              endIndent: 150,
            ),
            Center(
              child: Container(
                width: 300,
                child: Column(
                  children: [
                    Text(
                      "Temukan kuemu di sini",
                      style: TextStyle(
                          fontFamily: "Urbanist",
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Color.fromRGBO(127, 127, 127, 1)),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Rasakan kenyamanan dan kebahagiaan dengan sepotong makanan manis hanya dari Taartely, buat kamu, ",
                      style: TextStyle(
                          fontFamily: "Urbanist",
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Color.fromRGBO(127, 127, 127, 1)),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 32, right: 32, top: 20),
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildContainerProduct(
                          context: context,
                          image: "images/cup.jpg",
                          name: "Kue warna ",
                          rating: "4.5",
                          price: "200.000",
                          review: "1034",
                          description:
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"),
                      
                _buildContainerProduct(
                          context: context,
                          image: "images/kue_eta.jpg",
                          name: "Kue warna warni 40 cm",
                          rating: "4.5",
                          price: "200.000",
                          review: "1034",
                          description:
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"),    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildContainerProduct(
                          context: context,
                          image: "images/cup.jpg",
                          name: "Kue warna warni 40 cm",
                          rating: "4.5",
                          price: "200.000",
                          review: "1034",
                          description:
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"),
                      _buildContainerProduct(
                          context: context,
                          image: "images/kue_eta.jpg",
                          name: "Kue warna warni 40 cm",
                          rating: "4.5",
                          price: "200.000",
                          review: "1034",
                          description:
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildContainerProduct(
                          context: context,
                          image: "images/cup.jpg",
                          name: "Kue warna warni 40 cm",
                          rating: "4.5",
                          price: "200.000",
                          review: "1034",
                          description:
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"),
                      _buildContainerProduct(
                          context: context,
                          image: "images/kue_eta.jpg",
                          name: "Kue warna warni 40 cm",
                          rating: "4.5",
                          price: "200.000",
                          review: "1034",
                          description:
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildContainerProduct(
                          context: context,
                          image: "images/cup.jpg",
                          name: "Kue warna warni 40 cm",
                          rating: "4.5",
                          price: "200.000",
                          review: "1034",
                          description:
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"),
                      _buildContainerProduct(
                          context: context,
                          image: "images/kue_eta.jpg",
                          name: "Kue warna warni 40 cm",
                          rating: "4.5",
                          price: "200.000",
                          review: "1034",
                          description:
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildContainerProduct(
                          context: context,
                          image: "images/cup.jpg",
                          name: "Kue warna warni 40 cm",
                          rating: "4.9",
                          price: "200.000",
                          review: "1034",
                          description:
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"),
                      _buildContainerProduct(
                          context: context,
                          image: "images/kue_eta.jpg",
                          name: "Kue warna warni 40 cm",
                          rating: "4.5",
                          price: "200.000",
                          review: "1034",
                          description:
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildContainerProduct(
          {required BuildContext context,
          required String image,
          required String name,
          required String rating,
          required String price,
          required String review,
          required String description}) =>
      GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return DetailProductPage(
              image: image,
              name: name,
              rating: rating,
              price: price,
              description: description,
            );
          }));
        },
        child: Container(
          height: 280,
          width: 180,
          decoration: BoxDecoration(
              border: Border.all(color: Color.fromRGBO(255, 0, 0, 0)),
              borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
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
                            fontFamily: "Urbanis",
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black),
                      )
                    ],
                  ))
            ],
          ),
        ),
      );
}
