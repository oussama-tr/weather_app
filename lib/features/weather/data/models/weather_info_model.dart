import 'package:weather_app/features/weather/domain/entities/weather_info.dart';

/// Data model for weather information, extending the [WeatherInfo] entity.
///
/// This class includes methods to serialize and deserialize weather data
/// to and from JSON format, enabling easy storage and retrieval.
class WeatherInfoModel extends WeatherInfo {
  /// Creates a [WeatherInfoModel] instance with the given weather details.
  const WeatherInfoModel({
    required super.main,
    required super.description,
    required super.iconCode,
    required super.temp,
    required super.feelsLike,
    required super.tempMin,
    required super.tempMax,
    required super.pressure,
    required super.humidity,
    required super.windSpeed,
    required super.windDeg,
    required super.cloudsAll,
    required super.country,
    required super.cityName,
    required super.sunrise,
    required super.sunset,
  });

  /// Creates a [WeatherInfoModel] instance from a JSON object.
  ///
  /// The [json] parameter is a map containing the weather data in JSON format.
  factory WeatherInfoModel.fromJson(Map<String, dynamic> json) {
    return WeatherInfoModel(
      main: json['weather'] != null && json['weather'].isNotEmpty
          ? json['weather'][0]['main'] ?? ''
          : '',
      description: json['weather'] != null && json['weather'].isNotEmpty
          ? json['weather'][0]['description'] ?? ''
          : '',
      iconCode: json['weather'] != null && json['weather'].isNotEmpty
          ? json['weather'][0]['icon'] ?? ''
          : '',
      temp: json['main'] != null ? json['main']['temp'] ?? 0.0 : 0.0,
      feelsLike: json['main'] != null ? json['main']['feels_like'] ?? 0.0 : 0.0,
      tempMin: json['main'] != null ? json['main']['temp_min'] ?? 0.0 : 0.0,
      tempMax: json['main'] != null ? json['main']['temp_max'] ?? 0.0 : 0.0,
      pressure: json['main'] != null ? json['main']['pressure'] ?? 0 : 0,
      humidity: json['main'] != null ? json['main']['humidity'] ?? 0 : 0,
      windSpeed: json['wind'] != null ? json['wind']['speed'] ?? 0.0 : 0.0,
      windDeg: json['wind'] != null ? json['wind']['deg'] ?? 0 : 0,
      cloudsAll: json['clouds'] != null ? json['clouds']['all'] ?? 0 : 0,
      country: json['sys'] != null ? json['sys']['country'] ?? '' : '',
      cityName: json['name'] ?? '',
      sunrise: json['sys'] != null ? json['sys']['sunrise'] ?? 0 : 0,
      sunset: json['sys'] != null ? json['sys']['sunset'] ?? 0 : 0,
    );
  }

  /// Converts this [WeatherInfoModel] instance to a JSON object.
  ///
  /// Returns a map containing the weather data in JSON format.
  Map<String, dynamic> toJson() {
    return {
      'weather': [
        {
          'main': main,
          'description': description,
          'iconCode': iconCode,
        }
      ],
      'main': {
        'temp': temp,
        'feels_like': feelsLike,
        'temp_min': tempMin,
        'temp_max': tempMax,
        'pressure': pressure,
        'humidity': humidity,
      },
      'wind': {
        'speed': windSpeed,
        'deg': windDeg,
      },
      'clouds': {
        'all': cloudsAll,
      },
      'sys': {
        'country': country,
        'sunrise': sunrise,
        'sunset': sunset,
      },
      'name': cityName,
    };
  }
}
