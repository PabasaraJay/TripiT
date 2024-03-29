import 'package:flutter/material.dart';
import 'package:tripit/pages/trip_history_page.dart';

class BudgetReportPage extends StatelessWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final int numberOfAdults;
  final int numberOfChildren;
  final String selectedTravelingMethod;

  const BudgetReportPage({
    Key? key,
    required this.startDate,
    required this.endDate,
    required this.numberOfAdults,
    required this.numberOfChildren,
    required this.selectedTravelingMethod, required List<String> selectedActivities,
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
                    Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TripHistoryPage(),
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

    double totalAdultExpenses = adultExpensePerDay * tripDuration * numberOfAdults;
    double totalChildExpenses = childExpensePerDay * tripDuration * numberOfChildren;

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
