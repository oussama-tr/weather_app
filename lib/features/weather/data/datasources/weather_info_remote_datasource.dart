import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/core/constants/constants.dart';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/features/city/domain/entities/city.dart';
import 'package:weather_app/features/weather/data/models/weather_info_model.dart';

/// Abstract class defining remote data source operations for weather information.
///
/// This class outlines methods for interacting with weather data from a remote
/// data source, mainly fetching weather information for a specific city.
abstract class WeatherInfoRemoteDataSource {
  /// Calls the OpenWeather API endpoint to retrieve weather information for a city.
  ///
  /// [city] is the city for which weather information is requested.
  /// Returns a [Future] that completes with a [WeatherInfoModel] containing the
  /// weather data. Throws a [ServerException] for all error codes.
  Future<WeatherInfoModel> getWeatherInfo(City city);
}

/// Implementation of [WeatherInfoRemoteDataSource] using [http.Client] for
/// HTTP requests.
///
/// This class provides methods to interact with weather data retrieved from
/// the OpenWeather API.
class WeatherInfoRemoteDataSourceImpl implements WeatherInfoRemoteDataSource {
  final http.Client client;

  /// Constructs a [WeatherInfoRemoteDataSourceImpl] instance with the given [client].
  ///
  /// [client] is an instance of [http.Client] used to perform HTTP requests.
  WeatherInfoRemoteDataSourceImpl({required this.client});

  /// Calls the OpenWeather API to retrieve weather information for a city.
  ///
  /// [city] is the city for which weather information is requested.
  /// Returns a [Future] that completes with a [WeatherInfoModel] containing
  /// the weather data. Throws a [ServerException] if the API call results in
  /// an error.
  @override
  Future<WeatherInfoModel> getWeatherInfo(City city) async {
    final response = await client.get(
      Uri.parse(Urls.currentWeatherByName(city.name)),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return Future.value(
        WeatherInfoModel.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        ),
      );
    } else {
      throw ServerException('Server Error');
    }
  }
}
