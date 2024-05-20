import 'package:flutter/material.dart';
import 'package:taartely_ui/pages/admin/add_category_page.dart';
import 'package:taartely_ui/pages/admin/edit_category_page.dart';

class CategoryManagementPage extends StatefulWidget {
  const CategoryManagementPage({super.key});

  @override
  State<CategoryManagementPage> createState() => _CategoryManagementPageState();
}

class _CategoryManagementPageState extends State<CategoryManagementPage> {
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
                "Kelola Category",
                style: TextStyle(
                  fontFamily: "Urbanist",
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        body: ListView(
          padding: EdgeInsets.only(left: 32, right: 32),
          children: [
            Container(
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
                        "Ada produk baru?",
                        style: TextStyle(
                            fontFamily: "Urbanist",
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                      Text(
                        "perbarui produkmu!",
                        style: TextStyle(
                            fontFamily: "Urbanist",
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            color: Colors.white),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return AddCategoryPage();
                              }));
                            },
                            child: Text(
                              " + Kategori",
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
            SizedBox(
              height: 20,
            ),
            Text(
              "Semua kategori",
              style: TextStyle(
                fontFamily: "Urbanist",
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            _buildCategory(category: "Kue Tart"),
            SizedBox(
              height: 20,
            ),
            _buildCategory(category: "Cookies"),
            SizedBox(
              height: 20,
            ),
            _buildCategory(category: "Hampers"),
            SizedBox(
              height: 20,
            ),
            _buildCategory(category: "Bolu"),
            SizedBox(
              height: 20,
            ),
            _buildCategory(category: "Pudding"),
          ],
        ),
      ),
    );
  }

  _buildCategory({required String category}) => Container(
        height: 70,
        width: 500,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color.fromRGBO(247, 248, 249, 1),
          border: Border.all(color: Color.fromRGBO(63, 63, 63, 1)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(category),
            Row(
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromRGBO(183, 180, 180, 1)),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return EditCategoryPage();
                      }));
                    },
                    child: Text("Edit",
                        style: TextStyle(
                            fontFamily: "Urbanis",
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: const Color.fromARGB(255, 255, 255, 255)))),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () {},
                    child: Text("Hapus",
                        style: TextStyle(
                            fontFamily: "Urbanis",
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Colors.black))),
              ],
            )
          ],
        ),
      );
}
