
import 'package:flutter/material.dart';
import 'package:food/share.dart';
import 'package:food/statemanagement.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

class SelectFoodForm extends StatefulWidget {
  const SelectFoodForm({super.key});

  

  @override
  State<SelectFoodForm> createState() => _SelectFoodFormState();
}

class _SelectFoodFormState extends State<SelectFoodForm> {
  

  ManageState manageState = Get.put(ManageState());

  

  LocationData? currentLocation;
  String address = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick to Donate'),
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns in the grid
          crossAxisSpacing: 8.0, // Spacing between columns
          mainAxisSpacing: 4.0, // Spacing between rows
        ),
        itemCount: manageState.shareFood.length,
        itemBuilder: (context, index) {
          return Container(
      height: 350,
      width: 200,
      decoration: BoxDecoration(
          color: Colors.blueGrey, borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            height: 2,
          ),
          Container(
            height: 45,
            width: 45,
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                    'assets/${manageState.shareFood[index]['name']}.jpg'), // Placeholder image URL
              ),
            ),
          ),
          Text(
            manageState.shareFood[index]['name'],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          
                ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>  const FoodUploadForm(),
                    ));
              
            },
            child: const Text('Donate'),
          ),
          const SizedBox(
            height: 2,
          ),
        ],
      ),
    );
        },
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
