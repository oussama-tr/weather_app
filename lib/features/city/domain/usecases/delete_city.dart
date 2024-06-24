import 'package:weather_app/features/city/domain/entities/city.dart';
import 'package:weather_app/features/city/domain/repositories/city_repository.dart';

/// Use case for deleting a city.
///
/// This class encapsulates the logic for deleting a city using a [CityRepository].
class DeleteCity {
  /// The repository responsible for city data operations.
  final CityRepository repository;

  /// Constructs a [DeleteCity] instance with the given [repository].
  DeleteCity(this.repository);

  /// Executes the use case to delete a city.
  ///
  /// [city] is the name of the city to be deleted.
  /// Returns a [Future] that completes when the operation finishes.
  Future<void> call(City city) {
    return repository.deleteCity(city);
  }
}
