import 'package:flutter/material.dart';
import 'package:taartely_ui/pages/create_order_page.dart';

class DuaPage extends StatefulWidget {
  const DuaPage({super.key});

  @override
  State<DuaPage> createState() => _DuaPageState();
}

class _DuaPageState extends State<DuaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.all(16.0),
            children: [
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
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Perbarui keranjang",
                    style: TextStyle(
                        fontFamily: "Urbanist",
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(148, 149, 155, 1),
                      padding: EdgeInsets.only(
                          left: 50, right: 50, top: 12, bottom: 12)),
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
                        "Rp." + "200000" + ",-",
                        style: TextStyle(
                            fontFamily: "Urbanist",
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CreateOrderPage();
                      }));
                    },
                    child: Text(
                      "Pesan",
                      style: TextStyle(
                          fontFamily: "Urbanist",
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: EdgeInsets.only(
                            left: 50, right: 50, top: 20, bottom: 20)),
                  ),
                ],
              ),
            ),
          ),
        ],
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
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    fontFamily: "Urbanist",
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 11,
                      color: Colors.amber,
                    ),
                    SizedBox(width: 4),
                    Text(
                      rating,
                      style: TextStyle(
                        fontFamily: "Urbanist",
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      "(1045 Reviews)",
                      style: TextStyle(
                        fontFamily: "Urbanist",
                        fontWeight: FontWeight.w400,
                        fontSize: 11,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.delete_outline),
                onPressed: () {},
              ),
              CounterWidget(quantity: quantity),
              SizedBox(height: 4),
            ],
          ),
        ],
      ),
    );
  }
}

class CounterWidget extends StatefulWidget {
  final int quantity;

  const CounterWidget({Key? key, required this.quantity}) : super(key: key);

  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter;

  _CounterWidgetState() : _counter = 0;

  @override
  void initState() {
    super.initState();
    _counter = widget.quantity;
  }

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
