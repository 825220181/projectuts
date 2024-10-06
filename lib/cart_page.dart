import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final Map<String, int> cart;

  CartPage({required this.cart});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void _removeItem(String item) {
    setState(() {
      widget.cart.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang Belanja'),
      ),
      body: widget.cart.isEmpty
          ? Center(child: Text('Keranjang Kosong'))
          : ListView.builder(
        itemCount: widget.cart.length,
        itemBuilder: (context, index) {
          String item = widget.cart.keys.elementAt(index);
          int quantity = widget.cart[item]!;
          return ListTile(
            title: Text('$item x$quantity'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _removeItem(item);
              },
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: widget.cart.isEmpty
                ? null
                : () {
              // Simulasi pembayaran
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Pembayaran'),
                  content: Text('Pembayaran berhasil!'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            },
            child: Text('Bayar Sekarang'),
          ),
        ),
      ),
    );
  }
}
