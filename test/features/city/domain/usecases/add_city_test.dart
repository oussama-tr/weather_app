import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/features/city/domain/repositories/city_repository.dart';
import 'package:weather_app/features/city/domain/usecases/add_city.dart';

import '../../../../constants.dart';
import 'add_city_test.mocks.dart';

@GenerateMocks([CityRepository])
void main() {
  late MockCityRepository mockCityRepository;
  late AddCity usecase;

  setUp(() {
    mockCityRepository = MockCityRepository();
    usecase = AddCity(mockCityRepository);
  });

  test('should add a city to the repository', () async {
    // Arrange
    when(mockCityRepository.addCity(any))
        .thenAnswer((_) async => const Right(null));

    // Act
    final result = await usecase(AddCityParams(city: kTestCity));

    // Assert
    expect(result, const Right(null));
    verify(mockCityRepository.addCity(kTestCity));
    verifyNoMoreInteractions(mockCityRepository);
  });

  test('should return a failure when the repository fails to add the city',
      () async {
    // Arrange
    when(mockCityRepository.addCity(any))
        .thenAnswer((_) async => const Left(AddCityFailure()));

    // Act
    final result = await usecase(AddCityParams(city: kTestCity));

    // Assert
    expect(result, const Left(AddCityFailure()));
    verify(mockCityRepository.addCity(kTestCity));
    verifyNoMoreInteractions(mockCityRepository);
  });
}
