import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/features/city/domain/entities/city.dart';
import 'package:weather_app/features/weather/domain/entities/weather_info.dart';

/// Abstract repository interface for managing weather information.
///
/// This interface defines methods to interact with weather data, mainly
/// fetching weather information for a specified city.
abstract class WeatherInfoRepository {
  /// Retrieves the weather information for a given city.
  ///
  /// [city] is the name of the city for which the weather information is requested.
  /// Returns a [Future] that completes with an [Either] containing either
  /// a [Failure] or a [WeatherInfo] instance with the weather details.
  Future<Either<Failure, WeatherInfo>> getWeatherInfo(City city);
}
