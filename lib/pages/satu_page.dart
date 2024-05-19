import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taartely_ui/pages/all_product_page.dart';

class SatuPage extends StatefulWidget {
  const SatuPage({super.key});

  @override
  State<SatuPage> createState() => _SatuPageState();
}

class _SatuPageState extends State<SatuPage> {
  int isSelected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 32, right: 32, top: 18),
            padding: EdgeInsets.all(22),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: Color.fromRGBO(158, 21, 69, 1)),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Kereasikan Kuemu!!",
                      style: TextStyle(
                          fontFamily: "Urbanist",
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                    Text(
                      "Kini kamu bisa membuat kue impianmu di Taartely",
                      style: TextStyle(
                          fontFamily: "Urbanist",
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.white),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            "custom kue",
                            style: TextStyle(
                                fontFamily: "Urbanist",
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black),
                          )),
                    )
                  ],
                ),
                Column(
                    // children: [Image.asset("name")],
                    ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 14,
              left: 32,
            ),
            child: Row(
              children: [
                _buildProductCategory(index: 0, name: "All product"),
                _buildProductCategory(index: 1, name: "Kue Tart"),
                _buildProductCategory(index: 2, name: "Cookies"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 32, right: 32, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Katalog Produk",
                  style: TextStyle(
                      fontFamily: "Urbanist",
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color.fromRGBO(30, 35, 44, 1)),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return AllProductPage();
                    }));
                  },
                  child: Text(
                    "Lihat semua",
                    style: TextStyle(
                        fontFamily: "Urbanist",
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ),
              ],
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
                    _buildContainerProduct(image: "images/cup.jpg"),
                    _buildContainerProduct(image: "images/kue_eta.jpg"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildContainerProduct(image: "images/cup.jpg"),
                    _buildContainerProduct(image: "images/kue_eta.jpg"),
                  ],
                ),
              ],
            ),
          )
        ], // disini list paranet
      ),
    ));
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

  _buildContainerProduct({required String image}) => Container(
        height: 300,
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
                  height: 220,
                  width: 180,
                )),
            Container(
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Kue Warna Warni 40 cm",
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
                          "4.5",
                          style: TextStyle(
                              fontFamily: "Urbanist",
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                        Text(
                          " (1045 Reviews)",
                          style: TextStyle(
                              fontFamily: "Urbanist",
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Color.fromRGBO(183, 183, 183, 1)),
                        ),
                      ],
                    ),
                    Text(
                      "RP. 200.000,-",
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
      );
}
