import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/features/city/data/datasources/city_local_data_source.dart';
import 'package:weather_app/features/city/data/models/city_model.dart';
import 'city_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late CityLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource =
        CityLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  final tCityModel =
      CityModel(name: 'Test City', long: 10.0, lat: 10.0, isCurrentCity: false);
  final tCityModelJson = jsonEncode(tCityModel.toJson());
  final tCityModelJsonList = [tCityModelJson];

  group('getCities', () {
    test('should return a list of cities from SharedPreferences', () async {
      // Arrange
      when(mockSharedPreferences.getStringList(any))
          .thenReturn(tCityModelJsonList);

      // Act
      final result = await dataSource.getCities();

      // Assert
      verify(mockSharedPreferences.getStringList('CITIES_KEY'));
      expect(
          result, equals([tCityModel])); // Using equals to check value equality
    });

    test(
        'should return an empty list when there are no cities in SharedPreferences',
        () async {
      // Arrange
      when(mockSharedPreferences.getStringList(any)).thenReturn([]);

      // Act
      final result = await dataSource.getCities();

      // Assert
      verify(mockSharedPreferences.getStringList('CITIES_KEY'));
      expect(result, equals([]));
    });
  });

  group('addCity', () {
    test('should add a new city to SharedPreferences', () async {
      // Arrange
      when(mockSharedPreferences.getStringList(any)).thenReturn([]);
      when(mockSharedPreferences.setStringList(any, any))
          .thenAnswer((_) async => true);

      // Act
      await dataSource.addCity(tCityModel);

      // Assert
      verify(mockSharedPreferences.setStringList(
          'CITIES_KEY', tCityModelJsonList));
    });

    test('should not add a city with an empty name', () async {
      // Arrange
      final emptyNameCity =
          CityModel(name: '', long: 10.0, lat: 10.0, isCurrentCity: false);
      when(mockSharedPreferences.getStringList(any)).thenReturn([]);

      // Act
      await dataSource.addCity(emptyNameCity);

      // Assert
      verifyNever(mockSharedPreferences.setStringList(any, any));
    });

    test('should not add a city that already exists', () async {
      // Arrange
      when(mockSharedPreferences.getStringList(any))
          .thenReturn(tCityModelJsonList);

      // Act
      await dataSource.addCity(tCityModel);

      // Assert
      verifyNever(mockSharedPreferences.setStringList(any, any));
    });
  });

  group('deleteCity', () {
    test('should delete a city from SharedPreferences', () async {
      // Arrange
      when(mockSharedPreferences.getStringList(any))
          .thenReturn(tCityModelJsonList);
      when(mockSharedPreferences.setStringList(any, any))
          .thenAnswer((_) async => true);

      // Act
      await dataSource.deleteCity(tCityModel);

      // Assert
      verify(mockSharedPreferences.setStringList('CITIES_KEY', []));
    });

    test('should not throw an error if city to delete does not exist',
        () async {
      // Arrange
      when(mockSharedPreferences.getStringList(any)).thenReturn([]);
      when(mockSharedPreferences.setStringList(any, any))
          .thenAnswer((_) async => true);

      // Act
      await dataSource.deleteCity(tCityModel);

      // Assert
      verify(mockSharedPreferences.setStringList('CITIES_KEY', []));
    });
  });
}
