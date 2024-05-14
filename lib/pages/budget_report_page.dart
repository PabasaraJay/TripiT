import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tripit/pages/trip_history_page.dart';

class BudgetReportPage extends StatelessWidget {
  final _firestore = FirebaseFirestore.instance;

  ///upload
  Future<void> submit(
      String tripName, // Added parameter
      String destination,
      DateTime? startDate,
      DateTime? endDate,
      int tripDuration,
      int numberOfAdults,
      int numberOfChildren,
      String selectedTravelingMethod,
      double totalExpenses) async {
  
    String idd = "$tripName";
    //

    final SingleBudgetReport =
        _firestore.collection("fulltripdetails").doc(idd);
    SingleBudgetReport.set({
      'code': idd,
      'TripName': tripName, // Save tripName to Firestore
      'Destination': destination, // Save destination to Firestore
      'StartDate': startDate,
      'EndDate': endDate,
      'Duration': tripDuration,
      'NoOfAdults': numberOfAdults,
      'NoOfChildren': numberOfChildren,
      'TravelMethod': selectedTravelingMethod,
      'Total': totalExpenses,
    });
  }

  /// end

  final DateTime? startDate;
  final DateTime? endDate;
  final int numberOfAdults;
  final int numberOfChildren;
  final String selectedTravelingMethod;
  final String tripName;
  final String destination;

  BudgetReportPage({
    Key? key,
    required this.startDate,
    required this.endDate,
    required this.numberOfAdults,
    required this.numberOfChildren,
    required this.selectedTravelingMethod,
    required this.tripName, // Added parameter
    required this.destination,
    required List<String> selectedActivities,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate trip duration in days
    int tripDuration = calculateTripDuration();

    // Calculate total expenses based on the trip duration and selected traveling method
    double totalExpenses = calculateExpenses(tripDuration);

    return Scaffold(
      appBar: AppBar(
        title: Text('Budget Report'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Trip Name: $tripName'), // Display tripName
            SizedBox(height: 8),
            Text('Destination: $destination'), // Display destination
            SizedBox(height: 16),
            Text('Trip Duration: $tripDuration days'),
            SizedBox(height: 8),
            Text('Number of Adults: $numberOfAdults'),
            SizedBox(height: 8),
            Text('Number of Children: $numberOfChildren'),
            SizedBox(height: 8),
            Text('Selected Traveling Method: $selectedTravelingMethod'),
            SizedBox(height: 8),
            Text('Total Expenses: ${totalExpenses.toStringAsFixed(2)} LKR'),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Add action for the first button
                  },
                  child: Text('View Route'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add action for the second button
                  },
                  child: Text('Download Report'),
                ),
                ElevatedButton(
                  onPressed: () {
                    submit(
                        tripName,
                        destination,
                        startDate,
                        endDate,
                        tripDuration,
                        numberOfAdults,
                        numberOfChildren,
                        selectedTravelingMethod,
                        totalExpenses);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TripHistoryPage(),
                      ),
                    );
                    // Add action for the third button
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Calculate trip duration in days
  int calculateTripDuration() {
    if (startDate != null && endDate != null) {
      Duration tripDuration = endDate!.difference(startDate!);
      return tripDuration.inDays + 1; // Adding 1 to include the start day
    }
    return 0;
  }

  // Calculate total expenses
  double calculateExpenses(int tripDuration) {
    double adultExpensePerDay = 2000;
    double childExpensePerDay = 1000;
    double vehicleExpensePerDay = 5000;
    double taxiExpensePerDay = 10000;
    double publicTransportExpensePerDay = 3000;

    double totalAdultExpenses =
        adultExpensePerDay * tripDuration * numberOfAdults;
    double totalChildExpenses =
        childExpensePerDay * tripDuration * numberOfChildren;

    double totalTravelingExpenses = 0.0;
    switch (selectedTravelingMethod) {
      case 'Personal Vehicle':
        totalTravelingExpenses = vehicleExpensePerDay * tripDuration;
        break;
      case 'Taxi':
        totalTravelingExpenses = taxiExpensePerDay * tripDuration;
        break;
      case 'Public Transport':
        totalTravelingExpenses = publicTransportExpensePerDay * tripDuration;
        break;
      default:
        totalTravelingExpenses = 0.0;
        break;
    }

    return totalAdultExpenses + totalChildExpenses + totalTravelingExpenses;
  }
}
