import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  final String roomName;
  final int roomPrice;

  PaymentPage({required this.roomName, required this.roomPrice});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? firstName;
  String? lastName;
  String? email;
  String? selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.roomName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              "Mon, Oct 7 - Tue, Oct 8 (1 night)",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 10),
            Text(
              widget.roomName,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text("1 King Bed • Non-smoking • Breakfast optional"),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            Text(
              "Guest Info",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: "First Name",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  firstName = value;
                });
              },
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: "Last Name",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  lastName = value;
                });
              },
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 10),
            Text(
              "Pilih Metode Pembayaran",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            RadioListTile(
              title: Row(
                children: [
                  Image.asset('assets/bca.jpg', height: 30),
                  SizedBox(width: 10),
                  Text("Transfer BCA"),
                ],
              ),
              value: 'bca_transfer',
              groupValue: selectedPaymentMethod,
              onChanged: (value) {
                setState(() {
                  selectedPaymentMethod = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Row(
                children: [
                  Image.asset('assets/bri.jpg', height: 30),
                  SizedBox(width: 10),
                  Text("Transfer BRI"),
                ],
              ),
              value: 'bri_transfer',
              groupValue: selectedPaymentMethod,
              onChanged: (value) {
                setState(() {
                  selectedPaymentMethod = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Row(
                children: [
                  Icon(Icons.credit_card, size: 30, color: Colors.blue),
                  SizedBox(width: 10),
                  Text("Kartu Kredit"),
                ],
              ),
              value: 'credit_card',
              groupValue: selectedPaymentMethod,
              onChanged: (value) {
                setState(() {
                  selectedPaymentMethod = value.toString();
                });
              },
            ),
            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Rp ${widget.roomPrice}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: selectedPaymentMethod != null
                  ? () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Booking Confirmed"),
                    content: Text(
                        "Booking atas nama $firstName $lastName berhasil dengan metode pembayaran $selectedPaymentMethod."),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text("OK"),
                      ),
                    ],
                  ),
                );
              }
                  : null,
              child: Text("Pay Now"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
