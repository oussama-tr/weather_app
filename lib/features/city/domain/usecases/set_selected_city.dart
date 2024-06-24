import 'package:weather_app/features/city/domain/entities/city.dart';
import 'package:weather_app/features/city/domain/repositories/city_repository.dart';

/// Use case for setting the selected city.
///
/// This class encapsulates the logic for setting the currently selected
/// city using a [CityRepository].
class SetSelectedCity {
  /// The repository responsible for city data operations.
  final CityRepository repository;

  /// Constructs a [SetSelectedCity] instance with the given [repository].
  SetSelectedCity(this.repository);

  /// Executes the use case to set the selected city.
  ///
  /// [city] is the name of the city to be set as the currently selected city.
  /// Returns a [Future] that completes when the operation finishes.
  Future<void> call(City city) {
    return repository.setSelectedCity(city);
  }
}
