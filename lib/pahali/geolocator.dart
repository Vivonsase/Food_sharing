import 'package:flutter/material.dart';
import 'package:food/pahali/eneo_maalum.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

class GetUserLocation extends StatefulWidget {
  const GetUserLocation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GetUserLocationState createState() => _GetUserLocationState();
}

class _GetUserLocationState extends State<GetUserLocation> {
  LocationData? currentLocation;
  String address = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (currentLocation != null)
                Text(
                    "Location: ${currentLocation?.latitude}, ${currentLocation?.longitude}"),
              if (currentLocation != null) Text("Address: $address"),
              MaterialButton(
                onPressed: () {
                  _getLocation().then((value) {
                    LocationData? location = value;
                    getLocationFromCoordinates(
                            location?.latitude, location?.longitude)
                        .then((value) {
                      setState(() {
                        currentLocation = location;
                        address = value;
                      });
                    });
                  });
                },
                color: Colors.purple,
                child: const Text(
                  "Pickup Location",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Center(
                child: currentLocation == null
                    ? const SizedBox()
                    : ElevatedButton(
                        onPressed: () {
                          openGoogleMaps(currentLocation?.latitude,
                              currentLocation?.longitude);
                        },
                        child: const Text('Map Guide'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  openGoogleMaps(double? latitude, double? longitude) async {
    String destinationCoordinates = '$latitude,$longitude';

    String googleMapsUrl =
        'https://www.google.com/maps/dir/?api=1&destination=$destinationCoordinates';

    if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
      await launchUrl(Uri.parse(googleMapsUrl));
    } else {
      throw 'Could not launch Google Maps';
    }
  }

  Future<LocationData?> _getLocation() async {
    Location location = Location();
    LocationData locationData;

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    locationData = await location.getLocation();

    return locationData;
  }
}
