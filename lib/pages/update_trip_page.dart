import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class UpdateTripDetailsPage extends StatefulWidget {
  final String tripId;

  UpdateTripDetailsPage({required this.tripId});

  @override
  _UpdateTripDetailsPageState createState() => _UpdateTripDetailsPageState();
}

class _UpdateTripDetailsPageState extends State<UpdateTripDetailsPage> {
  final firestore = FirebaseFirestore.instance;
  late String tripId;
  late TextEditingController destinationController;
  late DateTime startDate;
  late DateTime endDate;
  late String travelMethod;

  // Define list of travel methods
  final List<String> travelMethods = [
    'Public Transport',
    'Taxi',
    'Personal Vehicle'
  ];

  @override
  void initState() {
    super.initState();
    tripId = widget.tripId;
    destinationController = TextEditingController();
    startDate = DateTime.now();
    endDate = DateTime.now();
    travelMethod = '';

    // Fetch existing trip details from Firestore
    fetchTripDetails();
  }

  void fetchTripDetails() async {
    DocumentSnapshot tripSnapshot =
        await firestore.collection('fulltripdetails').doc(tripId).get();

    if (tripSnapshot.exists) {
      setState(() {
        destinationController.text = tripSnapshot['Destination'];
        startDate = (tripSnapshot['StartDate'] as Timestamp).toDate();
        endDate = (tripSnapshot['EndDate'] as Timestamp).toDate();
        travelMethod = tripSnapshot['TravelMethod'];
      });
    }
  }

  Future<void> updateTripDetails() async {
    await firestore.collection('fulltripdetails').doc(tripId).update({
      'Destination': destinationController.text,
      'StartDate': startDate,
      'EndDate': endDate,
      'TravelMethod': travelMethod,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Trip Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: destinationController,
              decoration: InputDecoration(labelText: 'Destination'),
            ),
            SizedBox(height: 20),
            Text('Start Date'),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: startDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (picked != null && picked != startDate)
                  setState(() {
                    startDate = picked;
                  });
              },
              child: Text(
                DateFormat('yyyy-MM-dd').format(startDate),
              ),
            ),
            SizedBox(height: 20),
            Text('End Date'),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: endDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (picked != null && picked != endDate)
                  setState(() {
                    endDate = picked;
                  });
              },
              child: Text(
                DateFormat('yyyy-MM-dd').format(endDate),
              ),
            ),
            SizedBox(height: 20),
            // Replace TextFormField with DropdownButtonFormField
            DropdownButtonFormField<String>(
              value: travelMethod,
              items: travelMethods.map((String method) {
                return DropdownMenuItem<String>(
                  value: method,
                  child: Text(method),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  travelMethod = value!;
                });
              },
              decoration: InputDecoration(labelText: 'Travel Method'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await updateTripDetails();
                Navigator.pop(context); // Go back to previous screen
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    destinationController.dispose();
    super.dispose();
  }
}
