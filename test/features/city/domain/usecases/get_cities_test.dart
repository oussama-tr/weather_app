import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/core/usecases/usecase.dart';
import 'package:weather_app/features/city/domain/entities/city.dart';
import 'package:weather_app/features/city/domain/repositories/city_repository.dart';
import 'package:weather_app/features/city/domain/usecases/get_cities.dart';

import 'get_cities_test.mocks.dart';

@GenerateMocks([CityRepository])
void main() {
  late MockCityRepository mockCityRepository;
  late GetCities usecase;

  setUp(() {
    mockCityRepository = MockCityRepository();
    usecase = GetCities(mockCityRepository);
  });

  final tCityList = [
    City(name: 'Test City 1', long: 10.0, lat: 10.0),
    City(name: 'Test City 2', long: 20.0, lat: 20.0),
  ];

  test('should get list of cities from the repository', () async {
    // Arrange
    when(mockCityRepository.getCities())
        .thenAnswer((_) async => Right(tCityList));

    // Act
    final result = await usecase(NoParams());

    // Assert
    expect(result, Right(tCityList));
    verify(mockCityRepository.getCities());
    verifyNoMoreInteractions(mockCityRepository);
  });

  test('should return a failure when the repository fails to get cities',
      () async {
    // Arrange
    when(mockCityRepository.getCities())
        .thenAnswer((_) async => const Left(GetCitiesFailure()));

    // Act
    final result = await usecase(NoParams());

    // Assert
    expect(result, const Left(GetCitiesFailure()));
    verify(mockCityRepository.getCities());
    verifyNoMoreInteractions(mockCityRepository);
  });
}
