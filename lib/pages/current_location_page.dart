import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocationPage extends StatefulWidget {
  const CurrentLocationPage({super.key});

  @override
  State<CurrentLocationPage> createState() => _CurrentLocationPageState();
}

class _CurrentLocationPageState extends State<CurrentLocationPage> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition initialPosition =
      CameraPosition(target: LatLng(6.914683, 79.973162), zoom: 14.0);

  static const CameraPosition targetPosition = CameraPosition(
      target: LatLng(3.914683, 82.973162),
      zoom: 14.0,
      bearing: 192.0,
      tilt: 60);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Location"),
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: initialPosition,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text("To the Lake! "),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> goToLake() async{
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(targetPosition));
  }
}
