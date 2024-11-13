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
                        Text(
                          '${roomSizes[index]}, ${roomViews[index]}, Floor: ${roomFloors[index]}',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'IDR ${roomPrices[index]} per night',
                          style: TextStyle(fontSize: 20, color: Colors.green),
                        ),
                        SizedBox(height: 16),
                        Divider(),
                        Text(
                          "Facilities",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          roomFacilities[index],
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                        SizedBox(height: 16),
                        Divider(),
                        Text(
                          "Bed & Meal Information",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          bedDetails[index],
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        SizedBox(height: 4),
                        Text(
                          mealInfo[index],
                          style: TextStyle(fontSize: 14, color: Colors.grey),
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
                            child: Text("Proceed to Payment"),
                          ),
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Back"),
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
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                    child: Image.asset(
                      roomImages[index],
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          roomNames[index],
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          roomFacilities[index],
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'IDR ${roomPrices[index]} per night',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.purple),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: ElevatedButton(
                      onPressed: () {
                        showRoomDetails(index);
                      },
                      child: Text('View'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, // Button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
