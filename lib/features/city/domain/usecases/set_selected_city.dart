import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/core/usecases/usecase.dart';
import 'package:weather_app/features/city/domain/entities/city.dart';
import 'package:weather_app/features/city/domain/repositories/city_repository.dart';

/// Use case for setting the selected city.
///
/// This class encapsulates the logic for setting the currently selected
/// city using a [CityRepository].
class SetSelectedCity extends UseCase<void, SetSelectedCityParams> {
  /// The repository responsible for city data operations.
  final CityRepository repository;

  /// Constructs a [SetSelectedCity] instance with the given [repository].
  SetSelectedCity(this.repository);

  /// Executes the use case to set the selected city.
  ///
  /// [city] is the name of the city to be set as the currently selected city.
  /// Returns a [Future] that completes when the operation finishes.
  @override
  Future<Either<Failure, void>> call(SetSelectedCityParams params) {
    return repository.setSelectedCity(params.city);
  }
}

class SetSelectedCityParams extends Equatable {
  final City city;
  const SetSelectedCityParams({required this.city});

  @override
  List<Object?> get props => [city];
}
