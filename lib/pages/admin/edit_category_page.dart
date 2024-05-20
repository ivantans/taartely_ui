import 'package:flutter/material.dart';

class EditCategoryPage extends StatefulWidget {
  const EditCategoryPage({super.key});

  @override
  State<EditCategoryPage> createState() => _EditCategoryPageState();
}

class _EditCategoryPageState extends State<EditCategoryPage> {
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
              "Edit Kategori",
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
                      hintText: "kategori baru",
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
                SizedBox(
                  height:660,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Edit kategori",
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
    ));
  }
}