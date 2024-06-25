import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

/// A class responsible for providing location-related services using Geolocator
/// and Geocoding libraries.
class LocationProvider {
  /// Retrieves the current device position.
  ///
  /// Returns a [Future] that completes with a [Position] object representing
  /// the current device location.
  Future<Position> providePosition() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  /// Retrieves a list of placemarks (location information) from given coordinates.
  ///
  /// [position] is the [Position] object containing latitude and longitude.
  /// Returns a [Future] that completes with a list of [Placemark] objects.
  Future<List<Placemark>> getCityFromPosition(Position position) async {
    return placemarkFromCoordinates(position.latitude, position.longitude);
  }

  /// Checks if location services are enabled on the device.
  ///
  /// Returns a [Future] that completes with a [bool], where `true` indicates
  /// location services are enabled and `false` indicates they are disabled.
  Future<bool> isLocationEnabled() {
    return Geolocator.isLocationServiceEnabled();
  }

  /// Checks the current location permission status.
  ///
  /// Returns a [Future] that completes with a [LocationPermission] value
  /// indicating the current location permission status.
  Future<LocationPermission> checkLocationPermission() async {
    return Geolocator.checkPermission();
  }

  /// Requests location permission from the user.
  ///
  /// Returns a [Future] that completes with a [LocationPermission] value
  /// indicating the user's response to the permission request.
  Future<LocationPermission> requestLocationPermission() async {
    return Geolocator.requestPermission();
  }
}
