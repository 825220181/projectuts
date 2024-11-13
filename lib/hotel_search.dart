import 'package:flutter/material.dart';
// Import halaman pemesanan hotel
// import 'hotel_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HotelSearchScreen(),
      debugShowCheckedModeBanner: false, // Menonaktifkan banner debug
    );
  }
}

class HotelSearchScreen extends StatefulWidget {
  @override
  _HotelSearchScreenState createState() => _HotelSearchScreenState();
}

class _HotelSearchScreenState extends State<HotelSearchScreen> {
  DateTime checkInDate = DateTime(2023, 11, 15);
  DateTime checkOutDate = DateTime(2023, 11, 20);
  String cityName = 'Delhi';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hotel Search'),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.white, // Menambahkan warna latar belakang
      body: SingleChildScrollView( // Tambahkan SingleChildScrollView untuk menghindari overflow
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'City / Area / Hotel Name',
                hintText: cityName,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectDate(context, true),
                    child: _buildDateField(
                      'Check In',
                      '${checkInDate.day} ${_monthName(checkInDate.month)} ${checkInDate.year}',
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectDate(context, false),
                    child: _buildDateField(
                      'Check Out',
                      '${checkOutDate.day} ${_monthName(checkOutDate.month)} ${checkOutDate.year}',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            _buildRoomGuestField(),
            SizedBox(height: 24.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Pastikan halaman ini ada di proyek Anda atau berikan navigasi alternatif
                  print("Search Hotel button pressed"); // Debugging print statement
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Ganti 'primary' dengan 'backgroundColor'
                  padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
                ),
                child: Text(
                  'Search Hotel',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, bool isCheckIn) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isCheckIn ? checkInDate : checkOutDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != (isCheckIn ? checkInDate : checkOutDate)) {
      setState(() {
        if (isCheckIn) {
          checkInDate = picked;
        } else {
          checkOutDate = picked;
        }
      });
    }
  }

  String _monthName(int month) {
    List<String> monthNames = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return monthNames[month - 1];
  }

  Widget _buildDateField(String label, String date) {
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: Colors.grey)),
          SizedBox(height: 5.0),
          Text(date, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildRoomGuestField() {
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Rooms & Guests', style: TextStyle(color: Colors.grey)),
          SizedBox(height: 5.0),
          Text('1 Room, 1 Guest', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
