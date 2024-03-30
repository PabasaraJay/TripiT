import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tripit/pages/my_trips_page.dart';
import 'package:tripit/pages/trip_history_page.dart';
import 'package:intl/intl.dart';

class TripDetails extends StatefulWidget {
  final String cd1;

  TripDetails({required this.cd1});

  @override
  _TripDetailsState createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  GlobalKey globalKey = new GlobalKey();
  final _firestore = FirebaseFirestore.instance;
  late String code;

  @override
  void initState() {
    super.initState();
    code = widget.cd1;
  }

  String _formatDateAndTime(Timestamp timestamp) {
    try {
      final dateTime = timestamp.toDate(); // Convert Timestamp to DateTime
      final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss'); // Customize format
      return dateFormat.format(dateTime);
    } catch (error) {
      print('Error converting timestamp: $error');
      return '';
    }
  }

  ///timestamp/*
  /* String _formatDateAndTime(Timestamp timestamp) {
    try {
      final dateTime = timestamp.toDate(); // Convert Timestamp to DateTime
      final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss'); // Customize format
      return dateFormat.format(dateTime);
    } catch (error) {
      print('Error converting timestamp: $error');
      return '';
    }
  }*/

  ///

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('fulltripdetails')
          .doc(code)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data;

          return MaterialApp(
            title: 'My Flutter App',
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.green,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text(
                  '${data?['TripName']}',
                  style: TextStyle(color: Colors.white),
                ),
                iconTheme: IconThemeData(color: Colors.white),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Trip Details
                        Text(
                          'Tour Details',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        // Trip Name
                        //buildDataRow('Trip Name', '${data?['TripName']}'),
                        // Destination
                        buildDataRow('Destination', '${data?['Destination']}'),
                        // Start Date
                        buildDataRow('Start Date',
                            _formatDateAndTime(data?['StartDate'])),
                        // End Date
                        buildDataRow(
                            'End Date', _formatDateAndTime(data?['EndDate'])),
                        // Travel Method
                        buildDataRow(
                            'Travel Method', '${data?['TravelMethod']}'),
                        SizedBox(height: 20),
                        // Budget Report
                        // Budget Report
                        Text(
                          'Budget Report',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue, // Set text color to blue
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[
                                200], // Set background color to light grey
                            borderRadius:
                                BorderRadius.circular(10), // Add border radius
                            border: Border.all(
                              color: Colors.blue, // Add border color
                              width: 2, // Set border width
                            ),
                          ),
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // No of Adults
                              buildDataRow(
                                  'No of Adults', '${data?['NoOfAdults']}'),
                              // No of Children
                              buildDataRow(
                                  'No of Children', '${data?['NoOfChildren']}'),
                              // Trip Duration
                              buildDataRow(
                                  'Trip Duration', '${data?['Duration']} days'),
                              // Total Expenses
                              buildDataRow('Total Expenses',
                                  'LKR ${data?['Total'].toStringAsFixed(2)}'),
                            ],
                          ),
                        ),

                        SizedBox(height: 20),

                        // Edit Button
                        ElevatedButton(
                          onPressed: () {
                            // Add functionality to edit button
                          },
                          child: Text('Edit'),
                        ),

                        // Delete Button
                        ElevatedButton(
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('fulltripdetails')
                                .doc(code)
                                .delete();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TripHistoryPage()),
                            );
                          },
                          child: Text('Delete'),
                        ),

                        SizedBox(height: 10), // Add space between buttons
                        
                        //Home Screen Button
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyTripsPage(),
                              ),
                            ); // Navigate to home screen
                          },
                          child: Text('Go to Home Screen'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}

Widget buildDataRow(String label, String value) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Text(
          label + ': ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(value),
      ],
    ),
  );
}
