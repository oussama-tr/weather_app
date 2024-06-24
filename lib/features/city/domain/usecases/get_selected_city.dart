import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/core/usecases/usecase.dart';
import 'package:weather_app/features/city/domain/entities/city.dart';
import 'package:weather_app/features/city/domain/repositories/city_repository.dart';

/// Use case for retrieving the selected city.
///
/// This class encapsulates the logic for fetching the currently selected
/// city using a [CityRepository].
class GetSelectedCity extends UseCase<City?, NoParams> {
  /// The repository responsible for city data operations.
  final CityRepository repository;

  /// Constructs a [GetSelectedCity] instance with the given [repository].
  GetSelectedCity(this.repository);

  /// Executes the use case to retrieve the selected city.
  ///
  /// Returns a [Future] that completes with an [Either] containing either
  /// a [Failure] or the currently selected [City].
  @override
  Future<Either<Failure, City?>> call(NoParams _) {
    return repository.getSelectedCity();
  }
}
