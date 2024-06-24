import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/features/city/data/datasources/city_local_data_source.dart';
import 'package:weather_app/features/city/domain/entities/city.dart';
import 'package:weather_app/features/city/domain/repositories/city_repository.dart';

/// Concrete implementation of [CityRepository] interface.
///
/// This repository class serves as an intermediary between the domain layer
/// and the data layer for managing city-related data. It interacts with
/// [CityLocalDataSource] to perform operations such as fetching cities,
/// adding, deleting and selecting a city locally.
class CityRepositoryImpl implements CityRepository {
  final CityLocalDataSource localDataSource;

  /// Constructs a [CityRepositoryImpl] instance with the provided [localDataSource].
  CityRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<City>>> getCities() async {
    try {
      final cities = await localDataSource.getCities();
      return Right(cities);
    } catch (e) {
      // If an error occurs during cities retrieval, return a GetCitiesFailure.
      return const Left(GetCitiesFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addCity(City city) async {
    try {
      await localDataSource.addCity(city);
      return const Right(null);
    } catch (e) {
      // If an error occurs when adding a city, return an AddCityFailure.
      return const Left(AddCityFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteCity(City city) async {
    try {
      await localDataSource.deleteCity(city);
      return const Right(null);
    } catch (e) {
      // If an error occurs when deleting a city, return a DeleteCityFailure.
      return const Left(DeleteCityFailure());
    }
  }

  @override
  Future<Either<Failure, City?>> getSelectedCity() async {
    try {
      final selectedCity = await localDataSource.getSelectedCity();
      return Right(selectedCity);
    } catch (e) {
      // If an error occurs when retrieving the selected city, return a GetSelectedCityFailure.
      return const Left(GetSelectedCityFailure());
    }
  }

  @override
  Future<Either<Failure, void>> setSelectedCity(City city) async {
    try {
      await localDataSource.setSelectedCity(city);
      return const Right(null);
    } catch (e) {
      // If an error occurs when setting the selected city, return a SetSelectedCityFailure.
      return const Left(SetSelectedCityFailure());
    }
  }
}
