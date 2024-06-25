import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/core/network/network_info.dart';
import 'package:weather_app/features/city/domain/entities/city.dart';
import 'package:weather_app/features/weather/data/datasources/weather_info_local_data_source.dart';
import 'package:weather_app/features/weather/data/datasources/weather_info_remote_data_source.dart';
import 'package:weather_app/features/weather/domain/entities/weather_info.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_info_repository.dart';

/// Implementation of the [WeatherInfoRepository] interface for managing weather
/// information.
///
/// This repository class handles fetching weather information either from
/// a remote or local datasource depending on device network connectivity.
class WeatherInfoRepositoryImpl implements WeatherInfoRepository {
  final WeatherInfoRemoteDataSource remoteDataSource;
  final WeatherInfoLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  /// Constructs a [WeatherInfoRepositoryImpl] instance with the given
  /// [remoteDataSource], [localDataSource] and [networkInfo].
  WeatherInfoRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  /// Retrieves weather information for the given [city].
  ///
  /// If the device is online, fetches weather data from the remote data source.
  /// If the device is offline, retrieves cached weather information from the
  /// local data source.
  ///
  /// Returns an [Either] containing either a [Failure] or a [WeatherInfo]
  /// instance. If a [ServerException] occurs during remote data fetching,
  /// returns a [ServerFailure]. If a [CacheException] occurs during local data
  /// retrieval, returns a [CacheFailure].
  @override
  Future<Either<Failure, WeatherInfo>> getWeatherInfo(City city) async {
    final isConnected = await networkInfo.isConnected;

    if (isConnected) {
      try {
        final remoteInfo = await remoteDataSource.getWeatherInfo(city);

        // Cache the last weather info for the city.
        localDataSource.cacheWeatherInfo(city.name, remoteInfo);

        return Right(remoteInfo);
      } on ServerException {
        return const Left(ServerFailure());
      }
    } else {
      try {
        final localWeatherInfo =
            await localDataSource.getCachedWeatherInfo(city.name);

        return Right(localWeatherInfo);
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
  }
}
