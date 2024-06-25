import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/features/city/data/datasources/city_local_data_source.dart';
import 'package:weather_app/features/city/data/models/city_model.dart';
import 'package:weather_app/features/city/domain/entities/city.dart';
import 'package:weather_app/features/city/domain/repositories/city_repository.dart';
import 'package:weather_app/features/city/domain/repositories/location_manager.dart';

/// Concrete implementation of [CityRepository] interface.
///
/// This repository class serves as an intermediary between the domain layer
/// and the data layer for managing city-related data. It interacts with
/// [CityLocalDataSource] to perform operations such as fetching cities,
/// adding and deleting a city.
class CityRepositoryImpl implements CityRepository {
  final CityLocalDataSource localDataSource;
  final LocationManager locationManager;

  /// Constructs a [CityRepositoryImpl] instance with the provided
  /// [localDataSource] and [LocationManager].
  CityRepositoryImpl({
    required this.localDataSource,
    required this.locationManager,
  });

  @override
  Future<Either<Failure, List<City>>> getCities() async {
    try {
      // Retrieve the current city from the location manager.
      final currentCityEither = await locationManager.getCurrentCityName();

      return await currentCityEither.fold(
        // If getting the current city fails, return the cities from the local
        // data source.
        (failure) async {
          final cities = await localDataSource.getCities();
          return Right(cities);
        },
        (currentCity) async {
          if (currentCity != null) {
            // Add the current city to the local data source.
            await localDataSource.addCity(
              CityModel(name: currentCity, isCurrentCity: true),
            );
          }
          // Retrieve the updated list of cities from the local data source.
          final cities = await localDataSource.getCities();

          return Right(cities);
        },
      );
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
}
