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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.roomName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            TextField(
              decoration: InputDecoration(labelText: "First Name"),
              onChanged: (value) {
                setState(() {
                  firstName = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: "Last Name"),
              onChanged: (value) {
                setState(() {
                  lastName = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: "Email"),
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
            Spacer(),
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
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Booking Confirmed"),
                    content: Text("Booking atas nama $firstName $lastName berhasil."),
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
              },
              child: Text("Book"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
