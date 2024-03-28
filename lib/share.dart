import 'package:flutter/material.dart';
import 'package:food/home.dart';
import 'package:food/pahali/eneo_maalum.dart';
import 'package:food/statemanagement.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

class FoodUploadForm extends StatefulWidget {
  const FoodUploadForm({super.key});


  @override
  // ignore: library_private_types_in_public_api
  _FoodUploadFormState createState() => _FoodUploadFormState();
}

class _FoodUploadFormState extends State<FoodUploadForm> {
  final TextEditingController _foodName = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ManageState manageState = Get.put(ManageState());

  LocationData? currentLocation;
  String address = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Upload Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 20),
              TextFormField(
                controller: _foodName,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Enter Food Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid food name.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Enter Quantity',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid quantity.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              // TextFormField(
              //   controller: _locationController,
              //   keyboardType: TextInputType.text,
              //   decoration: const InputDecoration(
              //     labelText: 'Enter Pickup Location',
              //     border: OutlineInputBorder(),
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter a valid location.';
              //     }
              //     return null;
              //   },
              // ),
             
              const SizedBox(height: 10),
              TextFormField(
                controller: _expiryController,
                keyboardType: TextInputType.datetime,
                decoration: const InputDecoration(
                  labelText: 'Enter Expiry Date (e.g., 26.03.2024)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid date.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
               Row(
                children: [
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
                      "Get location",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  if (currentLocation != null)
                // Text(
                //     "Location: ${currentLocation?.latitude}, ${currentLocation?.longitude}"),
              if (currentLocation != null) Text("Loc: $address"),
                ],
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    int? enteredInteger =
                        int.tryParse(_quantityController.text);
                    if (enteredInteger != null) {
                      manageState.foods.add({
                        'name': _foodName.text,
                        'donor': 'donor1',
                        'quantity': enteredInteger,
                        'location': _locationController.text,
                        'expiry': _expiryController.text,
                        'lat': currentLocation?.latitude,
                        'lon': currentLocation?.longitude,
                        'loc': address
                      });
                      Get.offAll(const HomePage());
                      Get.snackbar(
                          'Donation Msg', 'You have successfully made a donation.');
                    } else {
                      Get.snackbar('Qty Error', 'Please enter a valid integer.');
                    }
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
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
