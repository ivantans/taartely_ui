import 'package:flutter/material.dart';
import 'package:taartely_ui/pages/admin_component/category/category_management_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taartely_ui/pages/admin_component/product/product_management_page.dart';

class SatuPage extends StatefulWidget {
  const SatuPage({super.key});

  @override
  State<SatuPage> createState() => _SatuPageState();
}

class _SatuPageState extends State<SatuPage> {
  String? _token;

  @override
  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('token');
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: EdgeInsets.only(left: 12),
          child: Text(
            "Admin Taartely",
            style: TextStyle(
                fontFamily: "Urbanist",
                fontWeight: FontWeight.bold,
                fontSize: 30),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 32, right: 32),
        children: [
          Container(
            child: _token == null?CircularProgressIndicator():Text(_token!),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(22),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: Color.fromRGBO(158, 21, 69, 1)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Omset",
                      style: TextStyle(
                          fontFamily: "Urbanist",
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white),
                    ),
                    Text(
                      "Rp. 23.000.000,-",
                      style: TextStyle(
                          fontFamily: "Urbanist",
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  "123 Pesanan Selesai",
                  style: TextStyle(
                      fontFamily: "Urbanist",
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.white),
                )
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 180,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    border: Border.all(color: Color.fromRGBO(231, 231, 232, 1)),
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.pending),
                        Text(
                          "12",
                          style: TextStyle(
                              fontSize: 30,
                              fontFamily: "Urbanist",
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Text("Menuggu",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Urbanist",
                            fontWeight: FontWeight.bold))
                  ],
                ),
              ),
              Container(
                width: 180,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    border: Border.all(color: Color.fromRGBO(231, 231, 232, 1)),
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.timelapse_sharp),
                        Text(
                          "12",
                          style: TextStyle(
                              fontSize: 30,
                              fontFamily: "Urbanist",
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Text("Perlu dibuat",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Urbanist",
                            fontWeight: FontWeight.bold))
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Center(
            child: Container(
              width: 300,
              child: Text(
                "Jangan lupa untuk selalu memperbarui produk dan kategori kue yang kamu jual!",
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Urbanist",
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(127, 127, 127, 1)),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ProductManagementPage();
              }));
            },
            child: Center(
              child: Container(
                height: 70,
                width: 500,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Kelola Product",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Urbanist",
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CategoryManagementPage();
              }));
            },
            child: Center(
              child: Container(
                height: 70,
                width: 500,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Kelola Kategori",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Urbanist",
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
