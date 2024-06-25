import 'package:equatable/equatable.dart';

/// Base class for all failures.
///
/// This class should be extended by specific failure types to represent
/// different error conditions in the application.
abstract class Failure extends Equatable {
  /// Constructor for [Failure].
  ///
  /// [properties] is an optional list of properties that will be used
  /// for equality checks.
  const Failure([List properties = const <dynamic>[]]);
}

/** General failures **/

/// Represents a failure when server call fails.
class ServerFailure extends Failure {
  final String message = 'Server Failure';

  /// Constructor for [ServerFailure].
  const ServerFailure();

  @override
  List<Object> get props => [message];
}

/// Represents a failure when retrieving cached data.
class CacheFailure extends Failure {
  final String message = 'Unable to get cached data';

  /// Constructor for [ServerFailure].
  const CacheFailure();
  @override
  List<Object> get props => [message];
}

/** City failures **/

/// Represents a failure when fetching cities fails.
class GetCitiesFailure extends Failure {
  final String message = 'Failed to get cities';

  /// Constructor for [GetCitiesFailure].
  const GetCitiesFailure();

  @override
  List<Object> get props => [message];
}

/// Represents a failure when adding a city fails.
class AddCityFailure extends Failure {
  final String message = 'Failed to add city';

  /// Constructor for [AddCityFailure].
  const AddCityFailure();

  @override
  List<Object> get props => [message];
}

/// Represents a failure when deleting a city fails.
class DeleteCityFailure extends Failure {
  final String message = 'Failed to delete city';

  /// Constructor for [DeleteCityFailure].
  const DeleteCityFailure();

  @override
  List<Object> get props => [message];
}

/// Represents a failure when getting location while location services are off.
class LocationServicesDisabledFailure extends Failure {
  final String message = 'Location services are disabled';

  /// Constructor for [LocationServicesDisabledFailure].
  const LocationServicesDisabledFailure();

  @override
  List<Object> get props => [message];
}

/// Represents a failure when getting location while location permission
/// is denied.
class LocationPermissionDeniedFailure extends Failure {
  final String message = 'Location permission is denied';

  /// Constructor for [LocationPermissionDeniedFailure].
  const LocationPermissionDeniedFailure();

  @override
  List<Object> get props => [message];
}

/// Represents a failure when getting location.
class GetLocationFailure extends Failure {
  final String message = 'Failed to get current location';

  /// Constructor for [GetLocationFailure].
  const GetLocationFailure();

  @override
  List<Object> get props => [message];
}
