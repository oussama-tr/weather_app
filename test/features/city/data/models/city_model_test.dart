import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/city/data/models/city_model.dart';
import 'package:weather_app/features/city/domain/entities/city.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  test(
    'should be a subclass of City entity',
    () async {
      // assert
      expect(CityModel(name: 'Test', long: 0, lat: 0), isA<City>());
    },
  );

  test(
    'should return a valid model from the JSON',
    () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('city.json'));
      // act
      final result = CityModel.fromJson(jsonMap);
      // assert
      expect(result, isA<CityModel>());
    },
  );

  test(
    'should return a JSON map containing proper data',
    () async {
      // arrange
      final cityModel = CityModel(name: 'Zocca', long: 10.99, lat: 44.34);
      // act
      final result = cityModel.toJson();
      // assert
      final expectedMap = {
        'name': 'Zocca',
        'long': 10.99,
        'lat': 44.34,
        'isCurrentCity': false,
      };
      expect(result, expectedMap);
    },
  );
}
