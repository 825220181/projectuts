import 'package:flutter/material.dart';
import 'payment_history_page.dart';

class PaymentPage extends StatefulWidget {
  final String roomName;
  final int roomPrice;
  final int roomQuantity;

  PaymentPage({
    required this.roomName,
    required this.roomPrice,
    required this.roomQuantity,
  });

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? selectedPaymentMethod;
  bool isButtonEnabled = false;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final Map<String, String> paymentAccounts = {
    'bca_transfer': '1234567890 (Hotel Reservation)',
    'bri_transfer': '9876543210 (Hotel Reservation)',
    'ovo': '081234567890 (Hotel Reservation)',
  };

  List<Map<String, dynamic>> paymentHistory = [];

  @override
  void initState() {
    super.initState();
    firstNameController.addListener(_updateButtonState);
    lastNameController.addListener(_updateButtonState);
    emailController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      isButtonEnabled = selectedPaymentMethod != null &&
          firstNameController.text.isNotEmpty &&
          lastNameController.text.isNotEmpty &&
          emailController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int totalPrice = widget.roomPrice * widget.roomQuantity;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.roomName),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PaymentHistoryPage(paymentHistory: paymentHistory),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              "Mon, Oct 7 - Tue, Oct 8 (${widget.roomQuantity} night${widget.roomQuantity > 1 ? 's' : ''})",
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
              controller: firstNameController,
              decoration: InputDecoration(
                labelText: "First Name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(
                labelText: "Last Name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 10),
            Text(
              "Select Payment Method",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Payment methods
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
                _updateButtonState();
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
                _updateButtonState();
              },
            ),
            RadioListTile(
              title: Row(
                children: [
                  Image.asset('assets/ovo.jpeg', height: 30),
                  SizedBox(width: 10),
                  Text("OVO"),
                ],
              ),
              value: 'ovo',
              groupValue: selectedPaymentMethod,
              onChanged: (value) {
                setState(() {
                  selectedPaymentMethod = value.toString();
                });
                _updateButtonState();
              },
            ),
            if (selectedPaymentMethod != null &&
                paymentAccounts.containsKey(selectedPaymentMethod))
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "No. Rekening: ${paymentAccounts[selectedPaymentMethod!]}",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
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
                  "Rp $totalPrice",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isButtonEnabled
                  ? () {
                setState(() {
                  paymentHistory.add({
                    'name':
                    "${firstNameController.text} ${lastNameController.text}",
                    'email': emailController.text,
                    'paymentMethod': selectedPaymentMethod,
                    'totalPrice': totalPrice,
                    'date': DateTime.now().toLocal().toString().split(' ')[0],
                  });
                });

                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Booking Confirmed"),
                    content: Text(
                        "Booking atas nama ${firstNameController.text} ${lastNameController.text} berhasil dengan metode pembayaran $selectedPaymentMethod."),
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
