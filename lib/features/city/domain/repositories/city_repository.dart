import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/features/city/domain/entities/city.dart';

/// Abstract repository interface for managing city data.
///
/// This interface defines methods to interact with city data, including
/// fetching cities, adding, and deleting a city.
abstract class CityRepository {
  /// Retrieves the list of cities.
  ///
  /// Returns a [Future] that completes with an [Either] containing either
  /// a [Failure] or a list of [City] instances.
  Future<Either<Failure, List<City>>> getCities();

  /// Adds a new city.
  ///
  /// Returns a [Future] that completes when the operation finishes.
  Future<Either<Failure, void>> addCity(City city);

  /// Deletes a city.
  ///
  /// Returns a [Future] that completes when the operation finishes.
  Future<Either<Failure, void>> deleteCity(City city);
}
