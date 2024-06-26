import 'dart:convert';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/features/weather/data/datasources/weather_info_local_data_source.dart';
import 'package:weather_app/features/weather/data/models/weather_info_model.dart';
import '../../../../constants.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'weather_info_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  MockSharedPreferences mockSharedPreferences = MockSharedPreferences();
  WeatherInfoLocalDataSourceImpl dataSource =
      WeatherInfoLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);

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
      final result = await dataSource.getCachedWeatherInfo(kTestCity.name);
      // assert
      verify(mockSharedPreferences
          .getString(dataSource.getCacheKey(kTestCity.name)));
      expect(result, equals(tWeatherInfoModel));
    });
    test('should throw a CacheException when there is no cached value',
        () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      // act and assert
      try {
        await dataSource.getCachedWeatherInfo(kTestCity.name);
        // If no exception is thrown, fail the test
        fail('Expected CacheException but did not throw');
      } catch (e) {
        // assert
        expect(e, isA<CacheException>());
      }
    });
  });

  group('setCachedWeatherInfo', () {
    test('should call SharedPreferences to cache the data', () async {
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);
      // act
      dataSource.cacheWeatherInfo(kTestCity.name, kTWeatherInfoModel);
      // assert
      final expectedJsonString = json.encode(kTWeatherInfoModel.toJson());
      verify(mockSharedPreferences.setString(
          dataSource.getCacheKey(kTestCity.name), expectedJsonString));
    });
  });
}
