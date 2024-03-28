import 'package:geocoding/geocoding.dart';

Future<String> getLocationFromCoordinates(
    double? latitude, double? longitude) async {
  try {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude!, longitude!);

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      String location = '${place.name}, ${place.locality}, ${place.country}';
      return location;
    } else {
      return 'No location information available';
    }
  } catch (e) {
    return 'Error: $e';
  }
}
