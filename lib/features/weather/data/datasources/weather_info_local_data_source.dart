import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/features/weather/data/models/weather_info_model.dart';

/// Abstract class defining local data source operations for weather information.
///
/// This class outlines methods for caching and retrieving weather data locally.
abstract class WeatherInfoLocalDataSource {
  /// Retrieves the cached [WeatherInfoModel] for the specified [cityName].
  ///
  /// Throws a [CacheException] if no cached data is present for the city.
  Future<WeatherInfoModel> getCachedWeatherInfo(String cityName);

  /// Caches the [weatherInfoToCache] for the specified [cityName]
  Future<void> cacheWeatherInfo(
      String cityName, WeatherInfoModel weatherInfoToCache);
}

/// Implementation of [WeatherInfoLocalDataSource] using `SharedPreferences`
/// for local data storage.
///
/// This class provides methods to cache and retrieve weather information
/// for multiple cities using `SharedPreferences`.
class WeatherInfoLocalDataSourceImpl implements WeatherInfoLocalDataSource {
  final SharedPreferences sharedPreferences;

  /// Constructs a [WeatherInfoLocalDataSourceImpl] instance with the provided
  /// [sharedPreferences].
  WeatherInfoLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<WeatherInfoModel> getCachedWeatherInfo(String cityName) {
    final jsonString = sharedPreferences.getString(getCacheKey(cityName));

    if (jsonString != null) {
      return Future.value(WeatherInfoModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException('Failed to get cached data for city: $cityName');
    }
  }

  @override
  Future<void> cacheWeatherInfo(
      String cityName, WeatherInfoModel weatherInfoToCache) async {
    try {
      await sharedPreferences.setString(
        getCacheKey(cityName),
        json.encode(weatherInfoToCache.toJson()),
      );
    } catch (e) {
      throw CacheException('Failed to cache data for city: $cityName');
    }
  }

  @visibleForTesting

  /// Helper method to generate cache key for each city
  String getCacheKey(String cityName) =>
      '${cityName.toUpperCase()}_CACHED_WEATHER_INFO';
}
