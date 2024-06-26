import 'dart:convert';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/features/city/domain/entities/city.dart';
import 'package:weather_app/features/weather/data/datasources/weather_info_local_data_source.dart';
import 'package:weather_app/features/weather/data/models/weather_info_model.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'weather_info_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  MockSharedPreferences mockSharedPreferences = MockSharedPreferences();
  WeatherInfoLocalDataSourceImpl dataSource =
      WeatherInfoLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);

  final tCity = City(name: 'Zocca', long: -1, lat: -1);

  group('getCachedWeatherInfo', () {
    final tWeatherInfoModel = WeatherInfoModel.fromJson(
        json.decode(fixture('cached_weather_info.json')));
    test(
        'should return WeatherInfoModel from SharedPreferences when there is one in the cache',
        () async {
      // arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture('cached_weather_info.json'));
      // act
      final result = await dataSource.getCachedWeatherInfo(tCity.name);
      // assert
      verify(
          mockSharedPreferences.getString(dataSource.getCacheKey(tCity.name)));
      expect(result, equals(tWeatherInfoModel));
    });
    test('should throw a CacheException when there is no cached value',
        () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      // act and assert
      try {
        await dataSource.getCachedWeatherInfo(tCity.name);
        // If no exception is thrown, fail the test
        fail('Expected CacheException but did not throw');
      } catch (e) {
        // assert
        expect(e, isA<CacheException>());
      }
    });
  });

  group('setCachedWeatherInfo', () {
    final tWeatherInfoModel = WeatherInfoModel(
      main: 'Rain',
      description: 'moderate rain',
      temp: 288.32,
      feelsLike: 288.35,
      tempMin: 286.8,
      tempMax: 289.21,
      pressure: 1013,
      humidity: 94,
      windSpeed: 2.51,
      windDeg: 207,
      cloudsAll: 100,
      country: 'IT',
      cityName: tCity.name,
      sunrise: 1719286385,
      sunset: 1719342254,
      iconCode: '10n',
    );
    test('should call SharedPreferences to cache the data', () async {
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);
      // act
      dataSource.cacheWeatherInfo(tCity.name, tWeatherInfoModel);
      // assert
      final expectedJsonString = json.encode(tWeatherInfoModel.toJson());
      verify(mockSharedPreferences.setString(
          dataSource.getCacheKey(tCity.name), expectedJsonString));
    });
  });
}
