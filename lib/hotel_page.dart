import 'package:flutter/material.dart';
import 'payment_page.dart';

class HotelReservationPage extends StatefulWidget {
  @override
  _HotelReservationPageState createState() => _HotelReservationPageState();
}

class _HotelReservationPageState extends State<HotelReservationPage> {
  List<String> roomNames = ["Kamar 01", "Kamar 02", "Kamar 03", "Kamar 04"];
  List<int> roomPrices = [350000, 350000, 250000, 250000];
  List<String> roomFacilities = [
    "Toilet, Lemari",
    "Toilet, Lemari, tv",
    "Toilet, Lemari",
    "Acc Toilet, Lemari, dll",
  ];
  List<String> roomImages = [
    'assets/kamar_01.jpeg',
    'assets/kamar_02.jpeg',
    'assets/kamar_03.jpeg',
    'assets/kamar_04.jpeg',
  ];

  void showRoomDetails(int index) {
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
                  roomImages[index],
                  height: 150,
                ),
              ),
              SizedBox(height: 16),
              Text(
                roomNames[index],
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Fasilitas: ${roomFacilities[index]}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Rp ${roomPrices[index]}',
                style: TextStyle(fontSize: 20, color: Colors.green),
              ),
              SizedBox(height: 16),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentPage(
                        roomName: roomNames[index],
                        roomPrice: roomPrices[index],
                      ),
                    ),
                  );
                },
                child: Text("Lanjut ke Pembayaran"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Kembali"),
              ),
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
        title: Text('Hotel Reservation'),
      ),
      body: ListView.builder(
        itemCount: roomNames.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(roomNames[index]),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Fasilitas: ${roomFacilities[index]}'),
                Text('Rp ${roomPrices[index]}'),
              ],
            ),
            trailing: ElevatedButton(
              onPressed: () {
                showRoomDetails(index);
              },
              child: Text('Pesan'),
            ),
          );
        },
      ),
    );
  }
}
