import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';

class GetLocation {

  final double latitude = 72.50369833333333;
  final double longitude = 23.034296666666666;

  Future<String?> getAddressFromLatLng(double latitude,
      double longitude) async {
    try {
      final List<Placemark> placemarks = await placemarkFromCoordinates(
          longitude, latitude);
      if (placemarks.isNotEmpty) {
        final Placemark place = placemarks[0];
        return '${place.street}\n${place.locality} ${place.postalCode}  ${place.country}';   //concat  locality postalcode  country
      } else {
        return 'Location not found';
      }
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
  }
}