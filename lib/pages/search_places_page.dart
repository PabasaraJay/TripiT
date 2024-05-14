// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:google_maps_webservice/places.dart';
// import 'package:google_api_headers/google_api_headers.dart';

// class SearchPlacesPage extends StatefulWidget {
//   const SearchPlacesPage({Key? key}) : super(key: key);

//   @override
//   State<SearchPlacesPage> createState() => _SearchPlacesPageState();
// }

// const kGoogleApiKey = 'AIzaSyAhtH2F8u2mzC8fLAEhld2IlmgmrqpNmo4';
// final homeScaffoldKey = GlobalKey<ScaffoldState>();

// class _SearchPlacesPageState extends State<SearchPlacesPage> {
//   static const CameraPosition initialCameraPosition =
//       CameraPosition(target: LatLng(6.9271, 79.8612), zoom: 14.0);

//   Set<Marker> markersList = {};

//   late GoogleMapController googleMapController;

//   final Mode _mode = Mode.overlay;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: homeScaffoldKey,
//       appBar: AppBar(
//         backgroundColor: Colors.green,
//         title: const Text(
//           "Search Places",
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(
//             initialCameraPosition: initialCameraPosition,
//             markers: markersList,
//             mapType: MapType.normal,
//             onMapCreated: (GoogleMapController controller) {
//               googleMapController = controller;
//             },
//           ),
//           ElevatedButton(
//               onPressed: _handlePressButton, child: const Text("Search Places"))
//         ],
//       ),
//     );
//   }

//   Future<void> _handlePressButton() async {
//     Prediction? p = await PlacesAutocomplete.show(
//         context: context,
//         apiKey: kGoogleApiKey,
//         onError: onError,
//         mode: _mode,
//         language: "en",
//         strictbounds: false,
//         types: [""],
//         decoration: InputDecoration(
//             hintText: 'Search',
//             focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(20),
//                 borderSide: BorderSide(color: Colors.white))),
//         components: [Component(Component.country, "lk")]);

//     displayPrediction(p!, homeScaffoldKey.currentState);
//   }

//   // void onError(PlacesAutocompleteResponse response) {
//   //   homeScaffoldKey.currentState!
//   //       .showSnackBar(SnackBar(content: Text(response.errorMessage!)));
//   // }
//   void onError(PlacesAutocompleteResponse response) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       elevation: 0,
//       behavior: SnackBarBehavior.floating,
//       backgroundColor: Colors.transparent,
//       content: AwesomeSnackbarContent(
//         title: 'Message',
//         message: response.errorMessage!,
//         contentType: ContentType.failure,
//       ),
//     ));
//   }

//   Future<void> displayPrediction(
//       Prediction p, ScaffoldState? currentState) async {
//     GoogleMapsPlaces places = GoogleMapsPlaces(
//         apiKey: kGoogleApiKey,
//         apiHeaders: await const GoogleApiHeaders().getHeaders());

//     PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);

//     final lat = detail.result.geometry!.location.lat;
//     final lng = detail.result.geometry!.location.lng;

//     markersList.clear();
//     markersList.add(Marker(
//         markerId: const MarkerId("0"),
//         position: LatLng(lat, lng),
//         infoWindow: InfoWindow(title: detail.result.name)));

//     setState(() {});

//     googleMapController
//         .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0));
//   }
// }
