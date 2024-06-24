import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/features/city/domain/entities/city.dart';
import 'package:weather_app/features/city/domain/repositories/city_repository.dart';

/// Use case for retrieving the list of cities.
///
/// This class encapsulates the logic for fetching a list of cities using
/// a [CityRepository].
class GetCities {
  /// The repository responsible for city data operations.
  final CityRepository repository;

  /// Constructs a [GetCities] instance with the given [repository].
  GetCities(this.repository);

  /// Executes the use case to retrieve a list of cities.
  ///
  /// Returns a [Future] that completes with an [Either] containing either
  /// a [Failure] or a list of [City] instances.
  Future<Either<Failure, List<City>>> call() {
    return repository.getCities();
  }
}
