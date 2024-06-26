import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/weather/data/models/weather_info_model.dart';
import 'package:weather_app/features/weather/domain/entities/weather_info.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tWeatherInfoModel = WeatherInfoModel(
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
    cityName: 'Zocca',
    sunrise: 1719286385,
    sunset: 1719342254,
    iconCode: '10n',
  );

  test(
    'should be a subclass of WeatherInfo entity',
    () async {
      // assert
      expect(tWeatherInfoModel, isA<WeatherInfo>());
    },
  );

  test(
    'should return a valid model from the JSON',
    () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('weather_info.json'));
      // act
      final result = WeatherInfoModel.fromJson(jsonMap);
      // assert
      expect(result, tWeatherInfoModel);
    },
  );

  test(
    'should return a JSON map containing proper data',
    () async {
      // act
      final result = tWeatherInfoModel.toJson();
      // assert
      final expectedMap = {
        'weather': [
          {
            'main': 'Rain',
            'description': 'moderate rain',
            'iconCode': '10n',
          },
        ],
        'main': {
          'temp': 288.32,
          'feels_like': 288.35,
          'temp_min': 286.8,
          'temp_max': 289.21,
          'pressure': 1013,
          'humidity': 94,
        },
        'wind': {
          'speed': 2.51,
          'deg': 207,
        },
        'clouds': {
          'all': 100,
        },
        'sys': {
          'country': 'IT',
          'sunrise': 1719286385,
          'sunset': 1719342254,
        },
        'name': 'Zocca',
      };
      expect(result, expectedMap);
    },
  );
}
