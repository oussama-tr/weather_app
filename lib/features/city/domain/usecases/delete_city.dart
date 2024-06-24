import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/core/usecases/usecase.dart';
import 'package:weather_app/features/city/domain/entities/city.dart';
import 'package:weather_app/features/city/domain/repositories/city_repository.dart';

/// Use case for deleting a city.
///
/// This class encapsulates the logic for deleting a city using a [CityRepository].
class DeleteCity extends UseCase<void, DeleteCityParams> {
  /// The repository responsible for city data operations.
  final CityRepository repository;

  /// Constructs a [DeleteCity] instance with the given [repository].
  DeleteCity(this.repository);

  /// Executes the use case to delete a city.
  ///
  /// [city] is the name of the city to be deleted.
  /// Returns a [Future] that completes when the operation finishes.
  @override
  Future<Either<Failure, void>> call(DeleteCityParams params) {
    return repository.deleteCity(params.city);
  }
}

class DeleteCityParams extends Equatable {
  final City city;
  const DeleteCityParams({required this.city});

  @override
  List<Object?> get props => [city];
}
