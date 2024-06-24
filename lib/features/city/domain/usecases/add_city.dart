import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/core/usecases/usecase.dart';
import 'package:weather_app/features/city/domain/entities/city.dart';
import 'package:weather_app/features/city/domain/repositories/city_repository.dart';

/// Use case for adding a city.
///
/// This class encapsulates the logic for adding a city using a [CityRepository].
class AddCity extends UseCase<void, AddCityParams> {
  /// The repository responsible for city data operations.
  final CityRepository repository;

  /// Constructs an [AddCity] instance with the given [repository].
  AddCity(this.repository);

  /// Executes the use case to add a city.
  ///
  /// [city] is the name of the city to be added.
  /// Returns a [Future] that completes when the operation finishes.
  @override
  Future<Either<Failure, void>> call(AddCityParams params) async {
    return await repository.addCity(params.city);
  }
}

class AddCityParams extends Equatable {
  final City city;
  const AddCityParams({required this.city});

  @override
  List<Object?> get props => [city];
}
