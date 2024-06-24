import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/core/usecases/usecase.dart';
import 'package:weather_app/features/weather/domain/entities/weather_info.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_info_repository.dart';

/// Use case for retrieving weather information for a given city.
///
/// This class encapsulates the logic for fetching weather information using
/// [WeatherInfoRepository].
class GetWeatherInfo implements UseCase<WeatherInfo, Params> {
  /// The repository responsible for weather information data operations.
  final WeatherInfoRepository repository;

  /// Constructs a [GetWeatherInfo] instance with the given [repository].
  GetWeatherInfo(this.repository);

  /// Executes the use case to retrieve weather information.
  ///
  /// Returns a [Future] that completes with an [Either] containing either
  /// a [Failure] or a [WeatherInfo] instance.
  @override
  Future<Either<Failure, WeatherInfo>> call(Params params) async {
    return await repository.getWeatherInfo(params.cityName);
  }
}

class Params extends Equatable {
  final String cityName;
  const Params({required this.cityName});

  @override
  List<Object?> get props => [cityName];
}
