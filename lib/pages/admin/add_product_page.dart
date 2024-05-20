import 'package:flutter/material.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
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
                "Tambah Produk",
                style: TextStyle(
                  fontFamily: "Urbanist",
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.only(left: 32, right: 32),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(232, 236, 244, 0))),
                      hintText: "Gambar",
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
                      hintText: "Nama Kue",
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
                      hintText: "Harga",
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
                      hintText: "Pilih Category",
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
                    isDense: true,
                    contentPadding: EdgeInsets.only(top: 46, bottom: 46, left: 8),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(232, 236, 244, 0))),
                      hintText: "Deskripsi",
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
                  height: 300,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Tambah produk",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
