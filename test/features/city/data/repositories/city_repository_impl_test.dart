import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/features/city/data/datasources/city_local_data_source.dart';
import 'package:weather_app/features/city/data/repositories/city_repository_impl.dart';
import 'package:weather_app/features/city/domain/entities/city.dart';
import 'package:weather_app/features/city/domain/repositories/location_manager.dart';

import '../../../../constants.dart';
import 'city_repository_impl_test.mocks.dart';

@GenerateMocks([
  CityLocalDataSourceImpl,
  LocationManager,
])
void main() {
  late CityRepositoryImpl repository;
  late MockCityLocalDataSourceImpl mockLocalDataSource;
  late MockLocationManager mockLocationManager;

  setUp(() {
    mockLocalDataSource = MockCityLocalDataSourceImpl();
    mockLocationManager = MockLocationManager();
    repository = CityRepositoryImpl(
      localDataSource: mockLocalDataSource,
      locationManager: mockLocationManager,
    );
  });

  group('getCities', () {
    final tCityList = [City(name: 'City 1', long: 1, lat: 1)];

    test(
        'should return cities from local data source when locationManager.getCurrentCity succeeds',
        () async {
      // Arrange
      when(mockLocationManager.getCurrentCity())
          .thenAnswer((_) async => Right(tCityList.first));

      when(mockLocalDataSource.getCities()).thenAnswer((_) async => tCityList);

      // Act
      final result = await repository.getCities();

      // Assert
      verify(mockLocalDataSource.getCities());
      expect(result, Right(tCityList));
    });

    test(
        'should add current city to local data source when locationManager.getCurrentCity succeeds',
        () async {
      // Arrange
      when(mockLocationManager.getCurrentCity())
          .thenAnswer((_) async => Right(tCityList.first));

      when(mockLocalDataSource.getCities()).thenAnswer((_) async => tCityList);

      // Act
      await repository.getCities();

      // Assert
      verify(mockLocalDataSource.addCity(tCityList.first));
    });

    test(
        'should return GetCitiesFailure when locationManager.getCurrentCity fails',
        () async {
      // Arrange
      when(mockLocationManager.getCurrentCity())
          .thenAnswer((_) async => const Left(GetCitiesFailure()));

      // Act
      final result = await repository.getCities();

      // Assert
      expect(result, const Left(GetCitiesFailure()));
    });
  });

  group('addCity', () {
    test('should add city to local data source', () async {
      // Arrange
      // Mock successful addition
      when(mockLocalDataSource.addCity(kTestCity)).thenAnswer((_) async {});

      // Act
      final result = await repository.addCity(kTestCity);

      // Assert
      verify(mockLocalDataSource.addCity(kTestCity));
      expect(result, const Right(null));
    });

    test('should return AddCityFailure when adding city fails', () async {
      // Arrange
      // Mock failure when adding city
      when(mockLocalDataSource.addCity(kTestCity))
          .thenThrow(const AddCityFailure());

      // Act
      final result = await repository.addCity(kTestCity);

      // Assert
      expect(result, const Left(AddCityFailure()));
    });
  });

  group('deleteCity', () {
    test('should delete city from local data source', () async {
      // Arrange
      // Mock successful deletion
      when(mockLocalDataSource.deleteCity(kTestCity)).thenAnswer((_) async {});

      // Act
      final result = await repository.deleteCity(kTestCity);

      // Assert
      verify(mockLocalDataSource.deleteCity(kTestCity));
      expect(result, const Right(null));
    });

    test('should return DeleteCityFailure when deleting city fails', () async {
      // Arrange
      // Mock failure when deleting city
      when(mockLocalDataSource.deleteCity(kTestCity))
          .thenThrow(const DeleteCityFailure());

      // Act
      final result = await repository.deleteCity(kTestCity);

      // Assert
      expect(result, const Left(DeleteCityFailure()));
    });
  });
}
