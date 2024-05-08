import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:google_generative_ai/google_generative_ai.dart';

class promptpage extends StatefulWidget {
  final String destination;
  final DateTime startDate;
  final DateTime endDate;
  final int budget;
  promptpage(
      {required this.destination,
      required this.startDate,
      required this.endDate,
      required this.budget});

  @override
  State<promptpage> createState() => _promptpageState();
}

class _promptpageState extends State<promptpage> {
  late DatabaseReference _msgref;

  String thisdistination = "";
  DateTime thisstartdate = DateTime(2022, 12, 31); // December 31, 2022
  DateTime thisenddate = DateTime(2023, 1, 1);
  int thisbudget = 0;
  String fetchedmsg = "";
  Future<void> setmsg(String num) async {
    await _msgref.set(num);
  }

  @override
  void initState() {
    super.initState();
    _msgref = FirebaseDatabase.instance.reference().child('msg');
    _msgref.onValue.listen((event) {
      final snapshot = event.snapshot;
      if (snapshot.value != null) {
        setState(() {
          fetchedmsg = snapshot.value as String;
        });
      }
    });

    thisdistination = widget.destination;
    thisstartdate = widget.startDate;
    thisenddate = widget.endDate;
    thisbudget = widget.budget;
    genprmpot();
  }

  //String promptmsg = 'You are planning a trip to $thisdistination from $thisstartdate to $thisenddate with a budget of $thisbudget. What are some activities you would like to do?';``
  String msg = "";
  Future<void> genprmpot() async {
    //String promptmsg = 'You are planning a trip to $thisdistination from $thisstartdate to $thisenddate with a budget of $thisbudget. What are some activities you would like to do?';
    String promptmsg =
        'Generate a travel itinerary for a trip to $thisdistination from $thisstartdate to $thisenddate.The traveler has a budget of LKR $thisbudget.Ensure the itinerary includes a mix of popular tourist attractions, dining options, and unique local experiences. Please provide specific details for each day, inlucding recommended activities, locations, dining suggestions.';
    try {
      final model = await _createGenerativeModel();
      final content = [Content.text(promptmsg)];
      final response = await model.generateContent(content);
      if (response != null) {
        msg = response.text!;
        setmsg(msg);
        print(msg);
      } else {
        print('Error: Response is null');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<GenerativeModel> _createGenerativeModel() async {
    return GenerativeModel(
        model: 'gemini-pro', apiKey: 'AIzaSyDClytG49R3ci29q5SnTnkWZom45cVRQ0Q');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      //print('pal');
                      genprmpot();
                    },
                    child: Text('Prompt'),
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(height: 20), // Add some spacing
              Text(
                '$fetchedmsg:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
