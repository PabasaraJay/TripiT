import 'package:flutter/material.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:tripit/pages/my_trip_to_page.dart';
import 'package:tripit/pages/budget_report_page.dart';


class TripPlannerPage extends StatefulWidget {
  const TripPlannerPage({Key? key}) : super(key: key);

  @override
  _TripPlannerPageState createState() => _TripPlannerPageState();
}

class _TripPlannerPageState extends State<TripPlannerPage> {

  final _firestore = FirebaseFirestore.instance;
  //final _auth = FirebaseAuth.instance;

  ///upload
  Future<void> upload(DateTime? startDate, DateTime? endDate, int numberOfAdults, int numberOfChildren,
      String selectedTravelingMethod) async {
    
    //meka wadak na ain krhn
    String idd = "$startDate $numberOfAdults";
    //

    final SinglePlan = _firestore.collection("triphistory").doc(idd);
    SinglePlan.set({
      'code': idd,//methnt holiday name eka
      'StartingDate': startDate,
      'Enddate': endDate,
      'NoOfAdults': numberOfAdults,
      'NoOfChildren': numberOfChildren,
      'TravelMethod': selectedTravelingMethod,
    });
  }
  /// end

  DateTime? _startDate;
  DateTime? _endDate;
  int _numberOfAdults = 1;
  int _numberOfChildren = 0;
  bool _swimmingSelected = false;
  bool _hikingSelected = false;
  bool _surfingSelected = false;
  bool _campingSelected = false;
  bool _shoppingSelected = false;
  bool _cuisineSelected = false;
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
        title: Text('Trip Planner'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            Text('Select Preferred Activities:'),
            SizedBox(height: 8),
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
            CheckboxListTile(
              title: Text('Cuisine'),
              value: _cuisineSelected,
              onChanged: (value) {
                setState(() {
                  _cuisineSelected = value ?? false;
                });
              },
            ),
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

    //upload(_startDate, _endDate, _numberOfAdults, _numberOfChildren, _selectedTravelingMethod);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BudgetReportPage(
          startDate: _startDate,
          endDate: _endDate,
          numberOfAdults: _numberOfAdults,
          numberOfChildren: _numberOfChildren,
          selectedActivities: [
            if (_swimmingSelected) 'Swimming',
            if (_hikingSelected) 'Hiking',
            if (_surfingSelected) 'Surfing',
            if (_campingSelected) 'Camping',
            if (_shoppingSelected) 'Shopping',
            if (_cuisineSelected) 'Cuisine',
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
