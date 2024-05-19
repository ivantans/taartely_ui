import 'package:flutter/material.dart';

class AllProductPage extends StatelessWidget {
  const AllProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:,
    );
  }
  
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