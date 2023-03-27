import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

Position userPosition = Position(longitude: 0.0, latitude: 0.0, timestamp: DateTime.now(), accuracy: 0, altitude: 0.0, heading: 0.0, speed: 0.0, speedAccuracy: 0.0); 

// var sampleLocations = [
//   Location(51.5074, 0.1278, "e707",),
//   Location(41.40338, 2.17403, "u907"),
//   Location(38.8951, -77.0364, "r567"),
// ];

/// Statefule Widget - Page to hold comment section, comment section will be integrated into Event Page
class LocationRequestPage extends StatefulWidget {
  const LocationRequestPage({super.key, required this.title});
  final String title;
  @override
  State<LocationRequestPage> createState() => _LocationRequestPage();
}

/// State class for Comment Page - _MyCommentPage
class _LocationRequestPage extends State<LocationRequestPage> {
  String locationRequestText =
      'Press The Button to allow access to your current location. This is required to find events near you!';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              locationRequestText,
            ),
            FloatingActionButton(
              // button that opens the comment section, a Modal Bottom Sheet
              onPressed: () async {
                if (await Geolocator.isLocationServiceEnabled() == true) {
                  userPosition = await Geolocator.getCurrentPosition(
                      desiredAccuracy: LocationAccuracy.high);
                      setState(() => locationRequestText = "Your location: $userPosition");
                } else {
                  setState(() => locationRequestText =
                      "Your Location Services are not enabled!");
                }
              },
              child: const Icon(Icons.location_on_outlined),
            ),
          ],
        ),

        // This Floating Action Button section can be added into the State class for the event page in order to integrate the comment section in
      ),
    );
  }
}
