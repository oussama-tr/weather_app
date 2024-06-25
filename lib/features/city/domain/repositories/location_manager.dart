import 'package:geolocator/geolocator.dart';
import 'package:weather_app/features/city/data/repositories/location_provider.dart';
import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failures.dart';

/// A manager class responsible for handling location-related operations.
///
/// This class utilizes a [LocationProvider] to fetch the current device
/// location and manage location permissions.
class LocationManager {
  final LocationProvider _locationProvider;
  String? _lastCity;

  /// Constructs a [LocationManager] instance with the provided [locationProvider].
  LocationManager(this._locationProvider);

  /// Retrieves the current city name.
  ///
  /// If [_lastCity] is not null, returns it immediately. Otherwise, checks for
  /// location permissions and retrieves the current position from [LocationProvider].
  /// Then fetches placemarks from the current position and returns the locality
  /// as the current city name.
  ///
  /// Returns a [Future] that completes with [Either<Failure, String?>].
  Future<Either<Failure, String?>> getCurrentCityName() async {
    if (_lastCity != null) {
      return Right(_lastCity);
    }

    final permissionCheck = await _checkAndRequestPermissions();

    return permissionCheck.fold(
      (failure) => Left(failure),
      (_) async {
        try {
          final currentPosition = await _locationProvider.providePosition();
          final placemarks =
              await _locationProvider.getCityFromPosition(currentPosition);

          if (placemarks.isNotEmpty) {
            final currentCity = placemarks.first.locality;

            _lastCity = currentCity;

            return Right(currentCity);
          }
          return const Left(GetLocationFailure());
        } catch (e) {
          return const Left(GetLocationFailure());
        }
      },
    );
  }

  /// Checks and requests location permissions if necessary.
  ///
  /// Checks if location services are enabled. If not, returns a
  /// [LocationServicesDisabledFailure]. Checks the current location permission
  /// and requests permission if it's denied.
  ///
  /// Returns a [Future] that completes with [Either<Failure, void>].
  Future<Either<Failure, void>> _checkAndRequestPermissions() async {
    final isLocationEnabled = await _locationProvider.isLocationEnabled();

    if (!isLocationEnabled) {
      return const Left(LocationServicesDisabledFailure());
    }

    final permission = await _locationProvider.checkLocationPermission();

    if (permission == LocationPermission.denied) {
      final requestedPermission =
          await _locationProvider.requestLocationPermission();

      if (requestedPermission == LocationPermission.denied ||
          requestedPermission == LocationPermission.deniedForever) {
        return const Left(LocationPermissionDeniedFailure());
      }
    }

    return const Right(null);
  }
}
