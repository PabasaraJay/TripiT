import 'package:flutter/material.dart';
//import 'package:tripit/pages/budget_report_page.dart';

class MyTripToPage extends StatelessWidget {
  const MyTripToPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  "My Trip To...",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Column(
                    children: [
                      Spacer(),
                      Image.asset(
                        'assets/forest.png',
                        height: MediaQuery.of(context).size.height * 0.5, // Keeping the image large
                      ),
                      const SizedBox(height: 40),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.maxFinite,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Add action for Tour Map button
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.green,
                                  elevation: 0,
                                  shape: const StadiumBorder(),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 8.0,
                                  ),
                                ),
                                child: const Text("Tour Map"),
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.maxFinite,
                              child: ElevatedButton(
                                onPressed: () {
                                  
                                  // Add action for Budget Report button
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.blue,
                                  elevation: 0,
                                  shape: const StadiumBorder(),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 8.0,
                                  ),
                                ),
                                child: const Text("Budget Report"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
