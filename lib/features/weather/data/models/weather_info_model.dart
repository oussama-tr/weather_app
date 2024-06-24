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
    required super.cod,
  });

  /// Creates a [WeatherInfoModel] instance from a JSON object.
  ///
  /// The [json] parameter is a map containing the weather data in JSON format.
  factory WeatherInfoModel.fromJson(Map<String, dynamic> json) {
    return WeatherInfoModel(
      main: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      temp: json['main']['temp'],
      feelsLike: json['main']['feels_like'],
      tempMin: json['main']['temp_min'],
      tempMax: json['main']['temp_max'],
      pressure: json['main']['pressure'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'],
      windDeg: json['wind']['deg'],
      cloudsAll: json['clouds']['all'],
      country: json['sys']['country'],
      cityName: json['name'],
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      cod: json['cod'],
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
      'cod': cod,
    };
  }
}
