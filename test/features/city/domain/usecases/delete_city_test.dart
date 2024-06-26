import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/features/city/domain/entities/city.dart';
import 'package:weather_app/features/city/domain/repositories/city_repository.dart';
import 'package:weather_app/features/city/domain/usecases/delete_city.dart';

import 'delete_city_test.mocks.dart';

@GenerateMocks([CityRepository])
void main() {
  late MockCityRepository mockCityRepository;
  late DeleteCity usecase;

  setUp(() {
    mockCityRepository = MockCityRepository();
    usecase = DeleteCity(mockCityRepository);
  });

  final tCity = City(name: 'Test City', long: 10.0, lat: 10.0);

  test('should delete city from the repository', () async {
    // Arrange
    when(mockCityRepository.deleteCity(any))
        .thenAnswer((_) async => const Right(null));

    // Act
    final result = await usecase(DeleteCityParams(city: tCity));

    // Assert
    expect(result, const Right(null));
    verify(mockCityRepository.deleteCity(tCity));
    verifyNoMoreInteractions(mockCityRepository);
  });

  test('should return a failure when the repository fails to delete city',
      () async {
    // Arrange
    when(mockCityRepository.deleteCity(any))
        .thenAnswer((_) async => const Left(DeleteCityFailure()));

    // Act
    final result = await usecase(DeleteCityParams(city: tCity));

    // Assert
    expect(result, const Left(DeleteCityFailure()));
    verify(mockCityRepository.deleteCity(tCity));
    verifyNoMoreInteractions(mockCityRepository);
  });
}
