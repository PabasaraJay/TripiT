import 'package:flutter/material.dart';
//import 'package:tripit/pages/current_location_page.dart';
import 'package:tripit/pages/my_trips_page.dart';
import 'package:tripit/pages/prompt_page.dart';
import 'package:tripit/pages/user_location.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            //color: Colors.blue, // Added color property
            child: const Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Good Evening",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        //color: Colors.white,
                      ),
                    ),
                    Text(
                      "Pabasara Jay",
                      style: TextStyle(
                        fontSize: 18,
                        //color: Colors.white,
                      ),
                    ),
                    /*Text(
                      "Welcome to TripIt",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),*/
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.all(16),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildButton("Your Location", () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const UserLocationPage(),
                  //   ),
                  // );
                }, Icons.location_on),
                _buildButton("Ai Assistant", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PromptGeneratorPage(),
                    ),
                  );
                }, Icons.assistant),
                _buildButton("Trip Planner", () {
                  // Add onPressed action for the third button
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyTripsPage(),
                    ),
                  );
                }, Icons.calendar_today),
                _buildButton("Profile", () {
                  // Add onPressed action for the fourth button
                }, Icons.person),
                _buildButton("Notification", () {
                  // Add onPressed action for the fifth button
                }, Icons.notifications),
                _buildButton("Travel Agents", () {
                  // Add onPressed action for the sixth button
                }, Icons.travel_explore),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed, IconData icon) {
    return MaterialButton(
      onPressed: onPressed,
      color: Colors.green,
      textColor: Colors.white,
      padding: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40),
          const SizedBox(height: 8),
          Text(
            text,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
