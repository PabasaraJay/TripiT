import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tripit/pages/response_page.dart';

class PromptGeneratorPage extends StatefulWidget {
  const PromptGeneratorPage({Key? key}) : super(key: key);

  @override
  _PromptGeneratorPageState createState() => _PromptGeneratorPageState();
}

class _PromptGeneratorPageState extends State<PromptGeneratorPage> {
  final _firestore = FirebaseFirestore.instance;

  String _destination = '';
  DateTime? _startDate;
  DateTime? _endDate;
  int _budget = 0;
  bool _swimmingSelected = false;
  bool _hikingSelected = false;
  bool _surfingSelected = false;
  bool _campingSelected = false;
  bool _shoppingSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Trip Planner',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              child: Text(
                _startDate != null
                    ? '${_startDate!.day}/${_startDate!.month}/${_startDate!.year}'
                    : 'Select Start Date',
              ),
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
              child: Text(
                _endDate != null
                    ? '${_endDate!.day}/${_endDate!.month}/${_endDate!.year}'
                    : 'Select End Date',
              ),
            ),
            SizedBox(height: 16),
            Text('Enter the Budget:'),
            SizedBox(height: 8),
            TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _budget = int.tryParse(value) ?? 0;
                });
              },
              decoration: InputDecoration(
                hintText: 'Enter the budget',
                border: OutlineInputBorder(),
              ),
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
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => promptpage(
                      destination: _destination,
                      startDate: _startDate ?? DateTime.now(),
                      endDate: _endDate ?? DateTime.now(),
                      budget: _budget,
                    ),
                  ),
                );
              },
              child: Text('Generate My Travel Plan'),
            ),
          ],
        ),
      ),
    );
  }
}
