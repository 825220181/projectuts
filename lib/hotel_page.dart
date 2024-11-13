import 'package:flutter/material.dart';
import 'payment_page.dart';

class HotelReservationPage extends StatefulWidget {
  @override
  _HotelReservationPageState createState() => _HotelReservationPageState();
}

class _HotelReservationPageState extends State<HotelReservationPage> {
  List<String> roomNames = ["Junior Suite", "Kamar 02", "Kamar 03", "Kamar 04"];
  List<int> roomPrices = [350000, 350000, 250000, 250000];
  List<String> roomSizes = ["39m²", "30m²", "25m²", "28m²"];
  List<String> roomFloors = ["1,2,3,5", "2,4", "1,3", "5"];
  List<String> roomViews = ["City view", "Garden view", "Mountain view", "Pool view"];
  List<String> roomFacilities = [
    "City view, Balcony, Bathtub, Free Wi-Fi, Non-smoking",
    "Garden view, Free Wi-Fi",
    "Mountain view, Non-smoking",
    "Pool view, Free Wi-Fi, Non-smoking",
  ];
  List<String> roomImages = [
    'assets/kamar_01.jpeg',
    'assets/kamar_02.jpeg',
    'assets/kamar_03.jpeg',
    'assets/kamar_04.jpeg',
  ];
  List<String> bedDetails = [
    "1 king bed (1.81m wide)",
    "1 queen bed",
    "2 twin beds",
    "1 king bed, 1 sofa bed",
  ];
  List<String> mealInfo = [
    "Meals not included. Breakfast: Rp 115,000 per person",
    "Meals included",
    "Meals not included",
    "Meals included",
  ];
  List<String> amenities = [
    "City view, Balcony, Bathtub, Deep Soaking Bathtub, Private bathroom, Air conditioning, Hair dryer, Refrigerator, Minibar",
    "Garden view, Free Wi-Fi, Refrigerator, Minibar",
    "Mountain view, Non-smoking, Air conditioning",
    "Pool view, Free Wi-Fi, Balcony, Minibar"
  ];

  List<int> roomQuantities = [1, 1, 1, 1];

  void showRoomDetails(int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return DraggableScrollableSheet(
              expand: false,
              builder: (context, scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
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
                        Row(
                          children: [
                            Icon(Icons.aspect_ratio, size: 20, color: Colors.grey),
                            SizedBox(width: 8),
                            Text(roomSizes[index]),
                            SizedBox(width: 16),
                            Icon(Icons.location_city, size: 20, color: Colors.grey),
                            SizedBox(width: 8),
                            Text(roomViews[index]),
                            SizedBox(width: 16),
                            Icon(Icons.stairs, size: 20, color: Colors.grey),
                            SizedBox(width: 8),
                            Text('Floor: ${roomFloors[index]}'),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.wifi, size: 20, color: Colors.grey),
                            SizedBox(width: 8),
                            Text("Free Wi-Fi"),
                            SizedBox(width: 16),
                            Icon(Icons.smoke_free, size: 20, color: Colors.grey),
                            SizedBox(width: 8),
                            Text("Non-smoking"),
                          ],
                        ),
                        SizedBox(height: 16),
                        Text(
                          'For ${bedDetails[index]}, ${mealInfo[index]}',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        SizedBox(height: 8),
                        Text(
                          bedDetails[index],
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Rp ${roomPrices[index]}',
                          style: TextStyle(fontSize: 20, color: Colors.green),
                        ),
                        SizedBox(height: 16),
                        Divider(),
                        Text(
                          "Amenities",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          amenities[index],
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        SizedBox(height: 16),
                        Divider(),
                        Text(
                          "Select Number of Rooms",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                setModalState(() {
                                  if (roomQuantities[index] > 1) {
                                    roomQuantities[index]--;
                                  }
                                });
                              },
                              icon: Icon(Icons.remove),
                            ),
                            Text(
                              '${roomQuantities[index]}',
                              style: TextStyle(fontSize: 18),
                            ),
                            IconButton(
                              onPressed: () {
                                setModalState(() {
                                  roomQuantities[index]++;
                                });
                              },
                              icon: Icon(Icons.add),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PaymentPage(
                                    roomName: roomNames[index],
                                    roomPrice: roomPrices[index] * roomQuantities[index],
                                    roomQuantity: roomQuantities[index],
                                  ),
                                ),
                              );
                            },
                            child: Text("Lanjut ke Pembayaran"),
                          ),
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Kembali"),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
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
