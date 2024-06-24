import 'package:equatable/equatable.dart';

/// A class representing detailed weather information.
///
/// This class contains various weather-related properties, including temperature,
/// humidity, wind conditions, and more, providing a comprehensive view of the
/// weather conditions in a particular location.
class WeatherInfo extends Equatable {
  /// The main weather condition (e.g., Rain, Snow, Clear).
  final String main;

  /// A more detailed description of the weather condition.
  final String description;

  /// The current temperature in degrees Celsius.
  final double temp;

  /// The perceived temperature in degrees Celsius.
  final double feelsLike;

  /// The minimum temperature observed in the current weather.
  final double tempMin;

  /// The maximum temperature observed in the current weather.
  final double tempMax;

  /// The atmospheric pressure in hPa.
  final int pressure;

  /// The humidity percentage.
  final int humidity;

  /// The wind speed in meters per second.
  final double windSpeed;

  /// The wind direction in degrees.
  final int windDeg;

  /// The percentage of cloud coverage.
  final int cloudsAll;

  /// The country code (e.g., US, GB).
  final String country;

  /// The name of the city.
  final String cityName;

  /// The sunrise time in Unix timestamp.
  final int sunrise;

  /// The sunset time in Unix timestamp.
  final int sunset;

  /// The status code of the response.
  final int cod;

  /// Constructs a [WeatherInfo] instance with the provided weather details.
  ///
  /// All parameters are required.
  const WeatherInfo({
    required this.main,
    required this.description,
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.windDeg,
    required this.cloudsAll,
    required this.country,
    required this.cityName,
    required this.sunrise,
    required this.sunset,
    required this.cod,
  });

  @override
  List<Object> get props => [
        main,
        description,
        temp,
        feelsLike,
        tempMin,
        tempMax,
        pressure,
        humidity,
        windSpeed,
        windDeg,
        cloudsAll,
        country,
        cityName,
        sunrise,
        sunset,
        cod,
      ];
}
