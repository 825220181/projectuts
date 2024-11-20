import 'package:flutter/material.dart';

class PaymentHistoryPage extends StatelessWidget {
  final List<Map<String, dynamic>> paymentHistory;

  PaymentHistoryPage({required this.paymentHistory});

  @override
  Widget build(BuildContext context) {
    print("Payment History Received: $paymentHistory");

    return Scaffold(
      appBar: AppBar(
        title: Text("Payment History"),
      ),
      body: paymentHistory.isEmpty
          ? Center(
        child: Text(
          "No payment history available.",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: paymentHistory.length,
        itemBuilder: (context, index) {
          final history = paymentHistory[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              leading: Icon(
                Icons.payment,
                color: Colors.blue,
                size: 40,
              ),
              title: Text(
                history['name'],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Text("Email: ${history['email']}"),
                  Text("Payment Method: ${history['paymentMethod']}"),
                  Text("Date: ${history['date']}"),
                ],
              ),
              trailing: Text(
                "Rp ${history['totalPrice']}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
