import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/features/city/domain/entities/city.dart';

/// Abstract repository interface for managing city data.
///
/// This interface defines methods to interact with city data, including
/// fetching cities, adding, deleting and selecting a city.
abstract class CityRepository {
  /// Retrieves the list of cities.
  ///
  /// Returns a [Future] that completes with an [Either] containing either
  /// a [Failure] or a list of [City] instances.
  Future<Either<Failure, List<City>>> getCities();

  /// Adds a new city.
  ///
  /// [city] is the name of the city to be added.
  /// Returns a [Future] that completes when the operation finishes.
  Future<Either<Failure, void>> addCity(City city);

  /// Deletes a city.
  ///
  /// [city] is the name of city to be deleted.
  /// Returns a [Future] that completes when the operation finishes.
  Future<Either<Failure, void>> deleteCity(City city);

  /// Retrieves the currently selected city, if any.
  ///
  /// Returns a [Future] that completes with an [Either] containing either
  /// a [Failure] or the currently selected [City].
  Future<Either<Failure, City?>> getSelectedCity();

  /// Sets the currently selected city.
  ///
  /// [city] is the name of the city to be set as the currently selected city.
  /// Returns a [Future] that completes when the operation finishes.
  Future<Either<Failure, void>> setSelectedCity(City city);
}
