import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tripit/pages/budget_report_page.dart';

class TripPlannerPage extends StatefulWidget {
  const TripPlannerPage({Key? key}) : super(key: key);

  @override
  _TripPlannerPageState createState() => _TripPlannerPageState();
}

class _TripPlannerPageState extends State<TripPlannerPage> {
  final _firestore = FirebaseFirestore.instance;

    Future<void> upload(
    String tripName,
    String destination,
    DateTime? startDate,
    DateTime? endDate,
    int numberOfAdults,
    int numberOfChildren,
    String selectedTravelingMethod,
  ) async {
    // Generate an ID for the trip based on its details
    String id = "$tripName";

    final tripDetails = _firestore.collection("triphistory").doc(id);
    tripDetails.set({
      'code': id,
      'TripName': tripName,
      'Destination': destination,
      'StartingDate': startDate,
      'Enddate': endDate,
      'NoOfAdults': numberOfAdults,
      'NoOfChildren': numberOfChildren,
      'TravelMethod': selectedTravelingMethod,
    });
  }

  String _tripName = '';
  String _destination = '';
  DateTime? _startDate;
  DateTime? _endDate;
  int _numberOfAdults = 1;
  int _numberOfChildren = 0;
  bool _swimmingSelected = false;
  bool _hikingSelected = false;
  bool _surfingSelected = false;
  bool _campingSelected = false;
  bool _shoppingSelected = false;
  String _selectedTravelingMethod = 'Personal Vehicle';
  List<String> _travelingMethods = [
    'Personal Vehicle',
    'Taxi',
    'Public Transport'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Trip Planner',
          style: TextStyle(color: Colors.white)
          ),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Enter Your Trip Name:'),
            SizedBox(height: 8),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  _tripName = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Enter a Unique Name for Your Trip',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text('Enter the Destination:'),
            SizedBox(height: 8),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  _destination = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Enter the destination',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text('Select Start Date:'),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(DateTime.now().year + 1),
                );
                if (selectedDate != null) {
                  setState(() {
                    _startDate = selectedDate;
                  });
                }
              },
              child: Text(_startDate != null
                  ? '${_startDate!.day}/${_startDate!.month}/${_startDate!.year}'
                  : 'Select Start Date'),
            ),
            SizedBox(height: 16),
            Text('Select End Date:'),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: _startDate ?? DateTime.now(),
                  firstDate: _startDate ?? DateTime.now(),
                  lastDate: DateTime(DateTime.now().year + 1),
                );
                if (selectedDate != null) {
                  setState(() {
                    _endDate = selectedDate;
                  });
                }
              },
              child: Text(_endDate != null
                  ? '${_endDate!.day}/${_endDate!.month}/${_endDate!.year}'
                  : 'Select End Date'),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Number of Adults:'),
                      SizedBox(height: 8),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            _numberOfAdults = int.tryParse(value) ?? 1;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter number of adults',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Number of Children:'),
                      SizedBox(height: 8),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            _numberOfChildren = int.tryParse(value) ?? 0;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter number of children',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Activities checkboxes
            Text('Select Preferred Activities:'),
            CheckboxListTile(
              title: Text('Swimming'),
              value: _swimmingSelected,
              onChanged: (value) {
                setState(() {
                  _swimmingSelected = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Hiking'),
              value: _hikingSelected,
              onChanged: (value) {
                setState(() {
                  _hikingSelected = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Surfing'),
              value: _surfingSelected,
              onChanged: (value) {
                setState(() {
                  _surfingSelected = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Camping'),
              value: _campingSelected,
              onChanged: (value) {
                setState(() {
                  _campingSelected = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Shopping'),
              value: _shoppingSelected,
              onChanged: (value) {
                setState(() {
                  _shoppingSelected = value ?? false;
                });
              },
            ),
            // Additional CheckboxListTile widgets for other activities...
            SizedBox(height: 16),
            Text('Select Traveling Method:'),
            SizedBox(height: 8),
            DropdownButton<String>(
              value: _selectedTravelingMethod,
              onChanged: (newValue) {
                setState(() {
                  _selectedTravelingMethod = newValue ?? 'Personal Vehicle';
                });
              },
              items: _travelingMethods
                  .map<DropdownMenuItem<String>>(
                    (value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                /*upload(
                  _tripName,
                  _destination,
                  _startDate,
                  _endDate,
                  _numberOfAdults,
                  _numberOfChildren,
                  _selectedTravelingMethod,
                );*/

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BudgetReportPage(
                      tripName: _tripName,
                      destination: _destination,
                      startDate: _startDate,
                      endDate: _endDate,
                      numberOfAdults: _numberOfAdults,
                      numberOfChildren: _numberOfChildren,
                      selectedActivities: [
                        if (_swimmingSelected) 'Swimming',
                        // Add other selected activities here...
                      ],
                      selectedTravelingMethod: _selectedTravelingMethod,
                    ),
                  ),
                );
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }


}
