import 'package:flutter/material.dart';
import 'cart_page.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<String> menu = ["Ayam Goreng", "Nasi Goreng", "Nasi Uduk", "Bakso Bakar", "Sate padang", "Teh Manis", "Lemon Tea", "Jus Jeruk", "Jus Alpukat", "Kopi"];
  List<int> prices = [10000, 19000, 22000, 13500, 18000, 4000, 7500, 8000,9000, 4500];
  List<String> descriptions = [
    "Ayam goreng ",
    "Nasi goreng ",
    "Nasi uduk ayam bakar",
    "Bakso sapi dengan 5 tusuk berjumlah 20 ",
    "Sate padang dengan 6 tusuk sate ",
    "Teh Manis bisa dingin atau panas",
    "Lemon Tea segar dan nikmat",
    "Jus Jeruk",
    "Jus Alpukat",
    "Kopi",
  ];
  List<String> images = [
    'assets/ayam_goreng.jpeg',
    'assets/nasi_goreng.jpeg',
    'assets/nasi_uduk.jpeg',
    'assets/bakso_bakar.jpeg',
    'assets/sate_padang.jpeg',
    'assets/teh_manis.jpeg',
    'assets/lemon_tea.jpeg',
    'assets/jus_jeruk.jpeg',
    'assets/jus_alpukat.jpeg',
    'assets/kopi.jpeg',
  ];
  Map<String, int> cart = {};
  List<int> ratings = [5, 4, 4, 5, 3, 5, 4, 5, 4, 4];
  List<bool> liked = [false, false, false, false, false, false, false, false, false, false];

  void addToCart(String item) {
    setState(() {
      if (cart.containsKey(item)) {
        cart[item] = cart[item]! + 1;
      } else {
        cart[item] = 1;
      }
    });
  }

  void removeFromCart(String item) {
    setState(() {
      if (cart.containsKey(item) && cart[item]! > 1) {
        cart[item] = cart[item]! - 1;
      } else {
        cart.remove(item);
      }
    });
  }

  void showFoodDetails(int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          height: 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  images[index],
                  height: 150,
                ),
              ),
              SizedBox(height: 16),
              Text(
                menu[index],
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                descriptions[index],
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Rp ${prices[index]}',
                style: TextStyle(fontSize: 20, color: Colors.green),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        liked[index] = !liked[index];
                      });
                    },
                    icon: Icon(
                      liked[index] ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                      color: liked[index] ? Colors.blue : null,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Fungsi untuk membagikan item (share)
                      print("Share ${menu[index]}");
                    },
                    icon: Icon(Icons.share),
                  ),
                  IconButton(
                    onPressed: () {
                      // Fungsi untuk melaporkan item (report)
                      print("Report ${menu[index]}");
                    },
                    icon: Icon(Icons.report),
                  ),
                ],
              ),
              Row(
                children: List.generate(5, (i) {
                  return Icon(
                    i < ratings[index] ? Icons.star : Icons.star_border,
                    color: Colors.yellow,
                  );
                }),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        removeFromCart(menu[index]);
                      });
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.remove),
                  ),
                  Text(cart[menu[index]]?.toString() ?? '0'),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        addToCart(menu[index]);
                      });
                      Navigator.pop(context); //
                    },
                    icon: Icon(Icons.add),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      addToCart(menu[index]);
                      Navigator.pop(context); //
                    },
                    child: Text("Add to Cart"),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Makanan dan Minuman'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(cart: cart),
                ),
              );
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: menu.length,
        itemBuilder: (context, index) {
          String item = menu[index];
          return ListTile(
            title: Text(item),
            subtitle: Text('Rp ${prices[index]}'), //
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    showFoodDetails(index); //
                  },
                  icon: Icon(Icons.info),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      liked[index] = !liked[index];
                    });
                  },
                  icon: Icon(
                    liked[index] ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                    color: liked[index] ? Colors.blue : null,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
